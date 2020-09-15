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
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: TemporaryHackWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TemporaryHack.PubSub,
  live_view: [signing_salt: System.get_env("SIGNING_SALT")]

# Configures Elixir's Logger
config :logger,
  backends: [:console],
  compile_time_purge_level: :debug

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: :all

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :temporary_hack, :pow,
  user: TemporaryHack.Users.User,
  repo: TemporaryHack.Repo,
  web_module: TemporaryHackWeb

# Blog configuration
config :temporary_hack, TemporaryHack.Blog,
  # Max number of blog posts to list on the landing page
  stubs: [
    count: 5,
    character_limit: 280
  ]

# The number of characters the body of the post is shortened to
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
