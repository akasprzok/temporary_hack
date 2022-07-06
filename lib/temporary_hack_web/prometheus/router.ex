defmodule TemporaryHackWeb.Prometheus.Router do
  @moduledoc """
  We want the nice error handling that Router gives us when
  a route other than /metrics is called, so we just add an empty
  router to the endpoint.
  """
  use TemporaryHackWeb, :router
end
