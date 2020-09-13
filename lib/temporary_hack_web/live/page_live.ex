defmodule TemporaryHackWeb.PageLive do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.Blog
  alias TemporaryHack.Frontpage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, tagline: Frontpage.random_tagline(), posts: Blog.list_posts())}
  end

  @impl true
  def handle_event("change_tagline", _params, socket) do
    {:noreply,
     update(socket, :tagline, fn current_tagline -> Frontpage.random_tagline(current_tagline) end)}
  end
end
