defmodule TemporaryHack.Github.Client do
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
    password: :temporary_hack |> Application.fetch_env!(:github) |> Keyword.fetch!(:access_token)

  plug Tesla.Middleware.Telemetry
  plug Tesla.Middleware.PathParams

  plug Tesla.Middleware.Retry,
    delay: 500,
    max_retries: 3,
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

  def repo(owner, repo) do
    Tracer.with_span "github_repo", %{attributes: [owner: owner, repo: repo]} do
      Cachex.fetch!(:github_repo, {owner, repo}, &do_repo/1)
    end
  end

  defp do_repo({owner, repo}) do
    params = [owner: owner, repo: repo]
    response = get("/repos/:owner/:repo", opts: [path_params: params])
    {:commit, response}
  end

  def latest_commit(owner, repo) do
    Tracer.with_span "latest_commit", %{attributes: [owner: owner, repo: repo]} do
      Cachex.fetch!(:github_latest_commit, {owner, repo}, &do_latest_commit/1)
    end
  end

  defp do_latest_commit({owner, repo}) do
    user = :temporary_hack |> Application.fetch_env!(:github) |> Keyword.fetch!(:user)
    params = [owner: owner, repo: repo]

    response =
      get("/repos/:owner/:repo/commits",
        opts: [path_params: params],
        query: [author: user, per_page: "1"]
      )

    {:commit, response}
  end
end
