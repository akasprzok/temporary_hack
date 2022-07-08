defmodule TemporaryHack.Clients.Github do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [
    {"Accept", "application/vnd.github+json"},
    {"User-Agent", "TemporaryHack"}
  ]
  plug Tesla.Middleware.BasicAuth, [username: "akasprzok", password: System.fetch_env!("GITHUB_ACCESS_TOKEN")]

  def zen do
    get("/zen")
  end

  def repos do
    get("user/repos")
  end
end
