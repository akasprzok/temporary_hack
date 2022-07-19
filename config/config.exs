# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :prometheus, TemporaryHack.PhoenixInstrumenter,
  controller_call_labels: [:controller, :action],
  duration_buckets: [
    10,
    25,
    50,
    100,
    250,
    500,
    1000,
    2500,
    5000,
    10_000,
    25_000,
    50_000,
    100_000,
    250_000,
    500_000,
    1_000_000,
    2_500_000,
    5_000_000,
    10_000_000
  ],
  registry: :default,
  duration_unit: :microseconds

config :prometheus, TemporaryHack.PipelineInstrumenter,
  labels: [:status_class, :method, :host, :scheme, :request_path],
  duration_buckets: [
    10,
    100,
    1_000,
    10_000,
    100_000,
    300_000,
    500_000,
    750_000,
    1_000_000,
    1_500_000,
    2_000_000,
    3_000_000
  ],
  registry: :default,
  duration_unit: :microseconds

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

config :temporary_hack, TemporaryHackWeb.Prometheus.Endpoint, url: [host: "localhost"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
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

# Configures Elixir's Logger
config :logger, :console,
  format: {LogfmtEx, :format},
  metadata: [:request_id, :mfa, :pid],
  utc_log: true

config :logfmt_ex, :opts,
  format: [:level, :message, :metadata],
  message_key: "msg"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

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
