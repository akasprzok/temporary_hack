defmodule TemporaryHackWeb.BlogController do
  use TemporaryHackWeb, :controller

  alias TemporaryHack.Blog

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", post: Blog.by_id(id))
  end
end
