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

defmodule TemporaryHackWeb.Prometheus.Router do
  @moduledoc """
  We want the nice error handling that Router gives us when
  a route other than /metrics is called, so we just add an empty
  router to the endpoint.
  """
  use Phoenix.Router
end
