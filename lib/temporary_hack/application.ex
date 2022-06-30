defmodule TemporaryHack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    prometheus()

    children = [
      {LogfmtEx, Application.get_env(:logfmt_ex, :opts)},
      # Start the Ecto repository
      TemporaryHack.Repo,
      # Start the Telemetry supervisor
      TemporaryHackWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TemporaryHack.PubSub},
      # Start the Endpoint (http/https)
      TemporaryHackWeb.Endpoint
      # Start a worker by calling: TemporaryHack.Worker.start_link(arg)
      # {TemporaryHack.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TemporaryHack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TemporaryHackWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def prometheus do
    TemporaryHack.PhoenixInstrumenter.setup()
    TemporaryHack.PipelineInstrumenter.setup()
    TemporaryHack.RepoInstrumenter.setup()
    Prometheus.Registry.register_collector(:prometheus_process_collector)
    TemporaryHack.PrometheusExporter.setup()
  end
end
