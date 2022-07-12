defmodule TemporaryHackWeb.ProjectController do
  use TemporaryHackWeb, :controller

  alias TemporaryHack.Portfolio
  alias TemporaryHack.Portfolio.Project

  alias TemporaryHack.Clients.Github, as: GithubClient

  def index(conn, _params) do
    projects = Portfolio.list_projects() |> Enum.map(&Map.from_struct/1)
    |> Enum.map(fn project ->
      {:ok, response} = GithubClient.repo(project.github_repo)
      github_info = response.body |> Map.take(["language"])
      Map.put(project, :github_info, github_info)
    end)

    view = self()

    render(conn, "index.html", projects: projects)
  end
end
