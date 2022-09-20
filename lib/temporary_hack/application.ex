defmodule TemporaryHack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias OpenTelemetry.{Span, Tracer}

  use Application

  require Logger

  import Cachex.Spec

  @impl true
  def start(_type, _args) do
    opentelemetry()

    children = [
      TemporaryHack.PromEx,
      # Start the Telemetry supervisor
      TemporaryHackWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TemporaryHack.PubSub},
      # Start the Endpoint (http/https)
      TemporaryHackWeb.Endpoint,
      {Task.Supervisor, name: TemporaryHackWeb.Portfolio.Project.EnrichmentSupervisor},
      Supervisor.child_spec(
        {Cachex,
         [
           name: :github_repo,
           expiration:
             expiration(
               default: :timer.minutes(4),
               interval: :timer.minutes(2),
               lazy: true
             )
         ]},
        id: :github_repo
      ),
      Supervisor.child_spec(
        {Cachex,
         [
           name: :github_latest_commit,
           expiration:
             expiration(
               default: :timer.minutes(4),
               interval: :timer.minutes(2),
               lazy: true
             )
         ]},
        id: :github_latest_commit
      ),
      Supervisor.child_spec(
        {Cachex,
         [
           name: :hex,
           expiration:
             expiration(
               default: :timer.minutes(4),
               interval: :timer.minutes(2),
               lazy: true
             )
         ]},
        id: :hex
      )
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

  def opentelemetry do
    OpentelemetryPhoenix.setup()

    :ok =
      :telemetry.attach(
        {__MODULE__, :router_dispatch_start},
        [:phoenix, :router_dispatch, :start],
        &__MODULE__.handle_router_dispatch_start/4,
        %{}
      )
  end

  def handle_router_dispatch_start(_event, _measurements, _meta, _config) do
    with span_ctx when span_ctx != :undefined <- Tracer.current_span_ctx() do
      Logger.metadata(
        traceID: span_ctx |> Span.trace_id() |> to_hex(),
        span_id: span_ctx |> Span.span_id() |> to_hex()
      )
    end
  end

  defp to_hex(int), do: int |> Integer.to_string(16) |> String.downcase()
end
