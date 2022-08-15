defmodule TemporaryHackWeb.PageLive.Index do
  @moduledoc false

  use TemporaryHackWeb, :surface_view

  alias TemporaryHackWeb.Components.{About, Card}
  alias TemporaryHack.{Accounts, Blog}

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    current_user = Accounts.get_user_by_session_token(token)
    posts = Blog.latest()

    {:ok, assign(socket, current_user: current_user, posts: posts)}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <div class="relative md:grid grid-cols-[20rem,_1fr] max-w-7xl mx-auto">
      <About />
      <div class="font-sans relative px-2 md:px-0 max-h-[90vh] md:overflow-auto">
        {#for post <- @posts}
          <Card title={post.title} id={post.id} date={post.date} description={post.description} />
        {/for}
      </div>
    </div>
    """
  end
end
