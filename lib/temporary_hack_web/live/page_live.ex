defmodule TemporaryHackWeb.PageLive do
  @moduledoc """
  LiveView of the landing page.
  Currently displays a small number of blog stubs, and a tagline.
  The tagline changes when the banner is clicked.
  """
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.Blog
  alias TemporaryHack.Frontpage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, tagline: Frontpage.random_tagline(), posts: Blog.get_stubs())}
  end

  @impl true
  def handle_event("change_tagline", _params, socket) do
    {:noreply,
     update(socket, :tagline, fn current_tagline -> Frontpage.random_tagline(current_tagline) end)}
  end
end
