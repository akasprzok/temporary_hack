# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :temporary_hack,
  ecto_repos: [TemporaryHack.Repo]

# Configures the endpoint
config :temporary_hack, TemporaryHackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IqfOsS8C56gWaf47ajK/g68CCnD4d43UWI9kWB3ukDkHxKPZx2mV5eCezWijKCbC",
  render_errors: [view: TemporaryHackWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TemporaryHack.PubSub,
  live_view: [signing_salt: "fO5wVXfl"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :temporary_hack, :pow,
  user: TemporaryHack.Users.User,
  repo: TemporaryHack.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
