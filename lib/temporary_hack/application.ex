defmodule TemporaryHack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias OpenTelemetry.{Span, Tracer}

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    opentelemetry()

    children = [
      # Start the Ecto repository
      TemporaryHack.Repo,
      # Start the Telemetry supervisor
      TemporaryHackWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TemporaryHack.PubSub},
      # Start the Endpoint (http/https)
      TemporaryHackWeb.Endpoint,
      TemporaryHackWeb.Prometheus.Endpoint,
      {Task.Supervisor, name: TemporaryHackWeb.Portfolio.Project.EnrichmentSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TemporaryHack.Supervisor]
    {:ok, pid} = Supervisor.start_link(children, opts)
    prometheus()
    {:ok, pid}
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TemporaryHackWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def opentelemetry do
    OpentelemetryPhoenix.setup()
    OpentelemetryEcto.setup([:temporary_hack, :repo])

    :ok = :telemetry.attach(
      {__MODULE__, :router_dispatch_start},
      [:phoenix, :router_dispatch, :start],
      &handle_router_dispatch_start/4,
      %{}
    )
  end

  def handle_router_dispatch_start(_event, _measurements, _meta, _config) do
    with span_ctx when span_ctx != :undefined <- Tracer.current_span_ctx() do
      Logger.metadata(
        trace_id: span_ctx |> Span.trace_id() |> to_hex(),
        span_id: span_ctx |> Span.span_id() |> to_hex()
      )
    end
  end

  defp to_hex(int), do: int |> Integer.to_string(16) |> String.downcase()

  defp prometheus do
    TemporaryHack.PhoenixInstrumenter.setup()
    TemporaryHack.PipelineInstrumenter.setup()
    TemporaryHack.RepoInstrumenter.setup()
    Prometheus.Registry.register_collector(:prometheus_process_collector)
    TemporaryHack.PrometheusExporter.setup()
  end
end
