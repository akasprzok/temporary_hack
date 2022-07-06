defmodule TemporaryHackWeb.Prometheus.Endpoint do
  @moduledoc """
  Serves Prometheus metrics on the /metrics path.
  We want this to be a separate endpoint from the public app
  so that nobody unauthorized can scrape our metrics.
  """
  use Phoenix.Endpoint, otp_app: :temporary_hack

  alias TemporaryHackWeb.Prometheus

  plug TemporaryHack.PrometheusExporter
  plug Prometheus.Router
end
