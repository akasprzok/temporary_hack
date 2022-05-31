# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

if Mix.env() != :prod do
  config :git_hooks,
    auto_install: true,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          {:cmd, "mix compile --warnings-as-errors"},
          {:mix_task, :format},
          {:mix_task, :credo, ["--strict"]}
        ]
      ]
    ]
end

config :temporary_hack,
  ecto_repos: [TemporaryHack.Repo]

# Configures the endpoint
config :temporary_hack, TemporaryHackWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TemporaryHackWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TemporaryHack.PubSub,
  live_view: [signing_salt: "eLKkoiun"]

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
  utc_log: true

config :logfmt_ex, :opts,
  format: [:level, :message, :metadata],
  message_key: "msg"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
