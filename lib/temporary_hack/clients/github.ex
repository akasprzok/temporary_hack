defmodule TemporaryHack.Clients.Github do
  @moduledoc """
  Github client.
  """
  use Tesla

  require OpenTelemetry.Tracer
  alias OpenTelemetry.Tracer

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON

  plug Tesla.Middleware.Headers, [
    {"Accept", "application/vnd.github+json"},
    {"User-Agent", "TemporaryHack"}
  ]

  plug Tesla.Middleware.BasicAuth,
    username: "akasprzok",
    password: System.fetch_env!("GITHUB_ACCESS_TOKEN")

  plug TemporaryHack.Middleware.Logger
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

  def zen do
    get("/zen")
  end

  def repos do
    get("user/repos")
  end

  def repo(user, repo) do
    Tracer.with_span "github_repo", %{attributes: [user: user, repo: repo]} do
      Cachex.fetch!(:github, {user, repo}, &do_repo/1)
    end
  end

  defp do_repo({user, repo}) do
    params = [user: user, repo: repo]
    get("/repos/:user/:repo", opts: [path_params: params])
  end
end
