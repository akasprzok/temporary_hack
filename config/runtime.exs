import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# Start the phoenix server if environment is set and running in a release
if System.get_env("PHX_SERVER") && System.get_env("RELEASE_NAME") do
  config :temporary_hack, TemporaryHackWeb.Endpoint, server: true
end

if config_env() == :dev do
  config :logger, :backends, [:console]
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  config :temporary_hack, TemporaryHack.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6

  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "https://temporaryhack.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :temporary_hack, TemporaryHackWeb.Endpoint,
    url: [host: host, port: 443],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  config :temporary_hack, TemporaryHack.Mailer,
    adapter: Swoosh.Adapters.Sendgrid,
    api_key: System.fetch_env!("SENDGRID_API_KEY")

  config :logger, :svadilfari,
    max_buffer: 10,
    client: [
      url: System.fetch_env!("LOKI_URL"),
      opts: [
        org_id: "tenant1"
      ]
    ],
    labels: [
      {"env", "prod"},
      {"service", "temporary_hack"}
    ]

  config :temporary_hack, TemporaryHack.PromEx,
    disabled: false,
    manual_metrics_start_delay: :no_delay,
    drop_metrics_groups: [],
    grafana: [
      host: System.fetch_env!("GRAFANA_HOST_URL"),
      auth_token: System.fetch_env!("GRAFANA_AUTH_TOKEN")
    ],
    metrics_server: [
      port: 9090,
      path: "/metrics"
    ]

  config :opentelemetry, :processors,
    otel_batch_processor: %{
      exporter: {
        :opentelemetry_exporter,
        %{
          protocol: :grpc,
          headers: [
            {"X-Org-ID", "tenant1"},
            {"authorization", System.fetch_env!("GRAFANA_TRACING_TOKEN")}
          ],
          endpoints: [
            {:https, 'tempo-us-central1.grafana.net', 443,
             [
               verify: :verify_peer,
               cacertfile: :certifi.cacertfile(),
               depth: 3,
               customize_hostname_check: [
                 match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
               ]
             ]}
          ]
        }
      }
    }
end
