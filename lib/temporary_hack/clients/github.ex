defmodule TemporaryHack.Clients.Github do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [
    {"Accept", "application/vnd.github+json"},
    {"User-Agent", "TemporaryHack"}
  ]
  plug Tesla.Middleware.BasicAuth, [username: "akasprzok", password: System.fetch_env!("GITHUB_ACCESS_TOKEN")]
  plug Tesla.Middleware.Logger
  plug Tesla.Middleware.Telemetry
  plug Tesla.Middleware.PathParams
  plug Tesla.Middleware.Retry,
    delay: 200,
    max_retries: 5,
    max_delay: 5_000,
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

  def repo(repo) do
    params = [repo: repo]
    get("/repos/akasprzok/:repo", opts: [path_params: params])
  end
end
