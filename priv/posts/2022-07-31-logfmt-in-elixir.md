%{
    title: "Logfmt in Elixir",
    tags: ~w(logging elixir),
    description: "A how-to on logging in the logfmt log format popularized by Heroku"
}
---

Logging in Elixir is pretty rudimentary: The `:console` logger can be configured to emit logs in a certain format according to a formatting string, specifying time, date, message, levek, node, and metadata fields.

A typical configuration will look like

```elixir
config :logger, :console,
  format: "$time $metadata[$level] $message\n"
```

which will emit logs along the lines of

```
18:43:12.439 user_id=13 [error] Hello\n
```

These logs are easy to sight read, however there are a variety of drawbacks to this approach. Firstly, the log is somewhat unstructured, and will require some kind of regex to be parsed by a log aggregator. Additionally, the metadata formatter will drop certain data types,such as structs, silently. Lastly, newlines and tabs aren't escaped, which makes for stack traces that are easy to sight read, but require some sort of multiline regexing to be properly ingested by aggregators such as Datadog or Grafana Loki.

### Logfmt

Logfmt is a, well, log format in which each line consists key=value paris:

```
ts=18:43:12.439 user_id=13 level=error msg=Hello\n
```

We can further customize the log format by specifying a `{Module, :function}` tuple for the `:console` logger's `:format` option:


```elixir
config :logger, :console,
    :format: {Module, :function}
```

`LogfmtEx` aims to address these shortcomings as a one-stop-shop for formatting logs.

Add the dependency to your `mix.exs`:

```elixir
{:logfmt_ex, "~> 0.1"}
```

And point your logger backend at it for formatting:

```elixir
config :logger, :console,
    format: {LogfmtEx, :format}
```