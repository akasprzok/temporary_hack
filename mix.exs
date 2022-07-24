defmodule TemporaryHack.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :temporary_hack,
      version: @version,
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {TemporaryHack.Application, []},
      extra_applications: [:logfmt_ex, :logger, :runtime_tools, :prometheus_ex, :prometheus_plugs],
      releases: [
        temporary_hack: [
          version: @version,
          applications: [
            opentelemetry_exporter: :permanent,
            opentelemetry: :temporary,
            temporary_hack: :permanent
          ]
        ]
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support/fixtures"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bcrypt_elixir, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:hackney, "~> 1.18"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:tesla, "~> 1.4"},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      # Telemetry
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      # Phoenix
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:phoenix, "~> 1.6.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      # Prometheus
      {:prometheus_ex, "~> 3.0"},
      {:prometheus_plugs, "~> 1.1.1"},
      {:prometheus_ecto, "~> 1.0"},
      {:prometheus_phoenix, "~> 1.0"},
      {:prometheus_process_collector, "~> 1.0"},
      # OpenTelemetry
      {:certifi, "~> 2.8"},
      {:opentelemetry, "~> 1.0"},
      {:opentelemetry_api, "~> 1.0"},
      {:opentelemetry_ecto, "~> 1.0"},
      {:opentelemetry_exporter, "~> 1.0"},
      {:opentelemetry_phoenix, "~> 1.0"},
      # Logging
      {:logfmt_ex, "~> 0.3"},
      {:svadilfari, "~> 0.1.1"},
      # Testing
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:floki, ">= 0.30.0", only: :test},
      # Documentation
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end
end
