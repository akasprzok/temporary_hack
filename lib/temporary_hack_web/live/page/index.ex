defmodule TemporaryHackWeb.PageLive.Index do
  @moduledoc false

  use TemporaryHackWeb, :surface_view

  alias TemporaryHackWeb.Components.{Card, Icons}
  alias TemporaryHack.{Accounts, Blog}

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    current_user = Accounts.get_user_by_session_token(token)
    posts = Blog.latest()

    {:ok, assign(socket, current_user: current_user, posts: posts, filter: &Function.identity/1, filter_selected: :blog)}
  end

  def mount(_params, _session, socket) do
    posts = Blog.latest()

    {:ok, assign(socket, posts: posts, filter: &Function.identity/1, filter_selected: :blog)}
  end
end
