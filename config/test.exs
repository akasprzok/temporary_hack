import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :temporary_hack, TemporaryHack.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
  database: "temporary_hack_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :temporary_hack, TemporaryHackWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OEjThbAbs3RQalizYD/VUFPrUslpM7Qjk5TFM74uCA0/WemnsQ7U/XdfERQeQ8D8",
  server: false

# In test we don't send emails.
config :temporary_hack, TemporaryHack.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
