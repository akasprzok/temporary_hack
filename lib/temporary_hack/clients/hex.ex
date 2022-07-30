defmodule TemporaryHack.Clients.Hex do
  @moduledoc """
  Hex client.
  """
  use Tesla

  require OpenTelemetry.Tracer
  alias OpenTelemetry.Tracer

  plug Tesla.Middleware.BaseUrl, "https://hex.pm"

  plug Tesla.Middleware.Headers, [
    {"User-Agent", "TemporaryHack"},
    {"Accept", "application/vnd.hex+erlang"},
    {"Authorization", System.fetch_env!("HEX_TOKEN")}
  ]

  plug TemporaryHack.Clients.ErlangMiddleware
  plug Tesla.Middleware.Logger, debug: false
  plug Tesla.Middleware.Telemetry
  plug Tesla.Middleware.PathParams

  plug Tesla.Middleware.Retry,
    delay: 500,
    max_retries: 5,
    max_delay: 1_000,
    jitter_factor: 0.2,
    should_retry: fn
      {:ok, %{status: status}} when status in [500] -> true
      {:ok, _} -> false
      {:error, _} -> true
    end

  def package(package) do
    Tracer.with_span "hex_package" do
      Cachex.fetch!(:hex, package, &do_package/1)
    end
  end

  defp do_package(package) do
    params = [package: package]
    get("/api/packages/:package", opts: [path_params: params])
  end
end
