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

Logfmt is a log format in which each line consists key=value paris:

```
ts=18:43:12.439 user_id=13 level=error msg=Hello\n
```

It's unambiguous, much easier to sight read than JSON, easy to search with `grep`, popularized by [Heroku](https://brandur.org/logfmt), and recommended by [Splunk](https://dev.splunk.com/enterprise/docs/developapps/addsupport/logging/loggingbestpractices/#Use-clear-key-value-pairs).

In Elixir, we can use the `LogfmtEx` library to convert our logs to logfmt.

Let's pull the library into our mix.exs:

```elixir
{:logfmt_ex, "~> 0.3"}
```

Then configure the `:console` logger to call LogfmtEx's `:format` function:


```elixir
config :logger, :console,
    :format: {LogfmtEx, :format}
```

Your logs will be emitted in logfmt with sensible defaults, but the order of fields, keys for timestamp and message, timestamp format, and more can be customized. See the [docs](https://hexdocs.pm/logfmt_ex/LogfmtEx.html) for more info.

### On TemporaryHack

This website uses LogfmtEx to format its logs. Here are some examples:

```
level=info msg="Finished request" traceID=8006567127ae87f1b2b4163ab05ebf3b pid=#PID<0.25691.2> mfa=TemporaryHack.Plug.Logger.call/2 path=/projects connection_type=sent span_id=f0f816caa49080aa status=200 duration_ms=3 method=GET
level=info msg="Finished request" pid=#PID<0.25614.2> mfa=TemporaryHack.Middleware.Logger.call/3 status=200 duration_ms=89.687 url=https://hex.pm/api/packages/:package method=GET query=""
```

