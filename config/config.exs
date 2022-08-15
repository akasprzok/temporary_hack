import Config

config :temporary_hack, TemporaryHack.Repo,
  # and maybe Ecto.LogEntry? Up to you
  loggers: [TemporaryHack.RepoInstrumenter]

config :temporary_hack,
  ecto_repos: [TemporaryHack.Repo]

# Configures the endpoint
config :temporary_hack, TemporaryHackWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TemporaryHackWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TemporaryHack.PubSub,
  live_view: [signing_salt: "eLKkoiun"]

# Configures the mailer
config :temporary_hack, TemporaryHack.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tesla, adapter: Tesla.Adapter.Hackney

# Configures Elixir's Logger
config :logger, utc_log: true

config :logger, :console,
  metadata: [
    :traceID,
    :pid,
    :mfa,
    :path,
    :connection_type,
    :span_id,
    :status,
    :duration_ms,
    :url,
    :method,
    :query
  ]

config :logger, :svadilfari,
  format: {LogfmtEx, :format},
  metadata: [
    :traceID,
    :pid,
    :mfa,
    :path,
    :connection_type,
    :span_id,
    :status,
    :duration_ms,
    :url,
    :method,
    :query
  ]

config :logfmt_ex, :opts,
  format: [:level, :message, :metadata],
  message_key: "msg",
  timestamp_key: "ts",
  timestamp_format: :iso8601

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :surface, :components, [
  {Surface.Components.Form.ErrorTag,
   default_translator: {TemporaryHackWeb.ErrorHelpers, :translate_error}}
]

config :phoenix, :logger, false

config :opentelemetry, :resource, service: %{name: "temporary_hack"}

config :opentelemetry, :processors, otel_batch_processor: %{exporter: :undefined}

config :tailwind,
  version: "3.1.5",
  default: [
    args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
