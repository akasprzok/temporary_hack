%{
    title: "Logfmt in Elixir",
    tags: ~w(logging elixir),
    description: "A how-to on logging in the logfmt log format popularized by Heroku"
}
---
Elixir's `:console` backend comes equipped with log formatting facilities.

A typical Elixir log message looks like

```
[error] We have a problem error_code=pc_load_letter file=lib/app.ex
```

And using a custom format, we can somewhat emulate logfmt:

```elixir
config :logger, :console,
    :format: "level=$level message=$message $metadata
```

However, there are blind spots to this approach - log messages without spaces are unnecessarily escaped, tabs and newlines aren't correctly escaped, and the built-in formatter doesn't know what to do with data types that aren't strings or numbers, opting to silently drop structs, maps, lists, and so on.


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