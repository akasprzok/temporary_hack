import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

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
