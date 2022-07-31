defmodule TemporaryHackWeb.BlogController do
  use TemporaryHackWeb, :controller

  alias TemporaryHack.Blog

  def index(conn, _params) do
    render(conn, "index.html", posts: Blog.posts())
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", post: Blog.by_id(id))
  end
end
