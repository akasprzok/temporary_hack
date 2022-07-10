defmodule TemporaryHackWeb.ProjectController do
  use TemporaryHackWeb, :controller

  alias TemporaryHack.Portfolio
  alias TemporaryHack.Portfolio.Project

  def index(conn, _params) do
    projects = Portfolio.list_projects()
    render(conn, "index.html", projects: projects)
  end
end
