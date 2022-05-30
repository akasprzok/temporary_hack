defmodule TemporaryHackWeb.PageController do
  use TemporaryHackWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
