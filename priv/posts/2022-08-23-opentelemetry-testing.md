%{
    title: "OpenTelemetry Tracing Testing",
    tags: ~w(tracing opentelemetry testing elixir),
    description: "An introduction to testing of OpenTelemetry spans in Elixir"
}
---

Generally, I would advise to focus your testing on integration tests and to avoid any tests that rely on the internal behaviour of your code. Doing so makes internal changes simple while providing high confidence that the functionality of your modules is intact.

But at times it becomes necessary to debug a missing trace. Or maybe you have alerts that use certain traces as inputs, and want to ensure that the shape of a trace or span doesn't change. This tutorial is intended for those occasions.

I'm assuming you have both `:opentelemetry` and `:opentelemetry_api` dependencies in your `mix.exs`:

```elixir
 defp deps do
    [
      # other deps
      {:opentelemetry, "~> 1.0"},
      {:opentelemetry_api, "~> 1.0"}
    ]
  end
```

We'll be using a modified version of the `hello` function from the OpenTelemetry [Getting Started](https://opentelemetry.io/docs/instrumentation/erlang/getting-started/) guide for Erlang/Elixir:

```elixir
# lib/otel_getting_started.ex
defmodule OtelGettingStarted do
  require OpenTelemetry.Tracer, as: Tracer

  def hello do
    Tracer.with_span "operation" do
      Tracer.set_attributes([{:a_key, "a value"}])
      :world
    end
  end
end
```

In order to test this function, we will set the exporter to `:undefined` and set a minimal delay on the batch processor:

```elixir
# config/test.exs
import Config

config :opentelemetry,
    traces_exporter: :undefined

config :opentelemetry, :processors, [
  {:otel_batch_processor, %{scheduled_delay_ms: 1}}
]
```

Now we're ready to test!

```elixir
defmodule OtelGettingStartedTest do
  use ExUnit.Case, async: true
  doctest OtelGettingStarted

  require Record
  @fields Record.extract(:span, from: "deps/opentelemetry/include/otel_span.hrl")
  Record.defrecordp(:span, @fields)

  test "greets the world" do
    :otel_batch_processor.set_exporter(:otel_exporter_pid, self())
    OpenTelemetry.get_tracer(:test_tracer)

    OtelGettingStarted.hello()

    attributes = :otel_attributes.new([a_key: "a_value"], 128, :infinity)

    assert_receive {:span, span(
      name: "operation",
      attributes: ^attributes
      )}
  end
end
```

Let's walk through this line by line:

```elixir
require Record
@fields Record.extract(:span, from: "deps/opentelemetry/include/otel_span.hrl")
Record.defrecordp(:span, @fields)
```

We use Elixir's [Record](https://hexdocs.pm/elixir/Record.html) module to extract the fields of the `Span` record from the erlang file in our deps folder. Then we define a set of private macros based on those fields.

We now have an Elixir representation of the spans that the erlang `:opentelemetry` library will emit.

```elixir
:otel_batch_processor.set_exporter(:otel_exporter_pid, self())
OpenTelemetry.get_tracer(:test_tracer)
```

In the test itself, we set the exporter to `:otel_exporter_pid`, which will send a message containing any received spans to the supplied PID, in this case `self()` - the test itself.

Then we get a [Tracer](https://opentelemetry.io/docs/instrumentation/erlang/instrumentation/#tracerprovider-and-tracers).

```elixir
OtelGettingStarted.hello()
```

We call our function that will create a span with a single attribute.

```elixir
attributes = :otel_attributes.new([a_key: "a_value"], 128, :infinity)

assert_receive {:span, span(
    name: "operation",
    attributes: ^attributes
    )}
```

The `:otel_exporter_pid` sends the span to the test process in the form `{:span, span}`, and we assert its reception.

Additionally, we use the [:otel_attributes](https://github.com/open-telemetry/opentelemetry-erlang/blob/main/apps/opentelemetry/src/otel_attributes.erl) module to help us create our single attribute, and pin it to assert that the attribute and its values were set as expected. There's a similar class for [:otel_events](https://github.com/open-telemetry/opentelemetry-erlang/blob/main/apps/opentelemetry/src/otel_events.erl) to aid in testing for event inclusion.

