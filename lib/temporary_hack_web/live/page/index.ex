defmodule TemporaryHackWeb.PageLive.Index do
  @moduledoc false

  use TemporaryHackWeb, :surface_view

  alias TemporaryHackWeb.Components.{About, Card}
  alias TemporaryHack.{Accounts, Blog}
  alias TemporaryHack.Portfolio
  alias TemporaryHack.Portfolio.ProjectWithMetadata

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    current_user = Accounts.get_user_by_session_token(token)

    socket
    |> assign(current_user: current_user)
    |> do_mount()
  end

  def mount(_params, _session, socket) do
    do_mount(socket)
  end

  defp do_mount(socket) do
    content = Blog.latest()
    filter = :blog
    filter_selected = :blog
    {:ok, assign(socket, content: content, filter: filter, filter_selected: filter_selected)}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <div class="relative md:grid grid-cols-[20rem,_1fr] max-w-7xl mx-auto">
      <About />
      <div class="font-sans relative px-2 md:px-0 max-h-[90vh] md:overflow-auto">
        {#for post <- @content}
          <Card title={post.title} link={"/blog/#{post.id}"} id={post.id} date={post.date} description={post.description} />
        {/for}
      </div>
    </div>
    """
    end
end
