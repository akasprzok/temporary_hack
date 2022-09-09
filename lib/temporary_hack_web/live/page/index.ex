defmodule TemporaryHackWeb.PageLive.Index do
  @moduledoc false

  use TemporaryHackWeb, :surface_view

  alias TemporaryHackWeb.Components.{About, Card}
  alias TemporaryHack.{Accounts, Blog}
  alias TemporaryHack.Blog.Post
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

  @impl true
  def handle_event("filter-content", %{"filter" => filter}, socket) do
    filter_selected = String.to_existing_atom(filter)

    filter =
      case filter_selected do
        :blog -> fn content -> match?(%Post{}, content) end
        :projects -> fn content -> match?(%ProjectWithMetadata{}, content) end
      end

    {:noreply, assign(socket, filter: filter, filter_selected: filter_selected)}
  end

  defp do_mount(socket) do
    content = Blog.latest() ++ Portfolio.list_projects()
    filter = fn content -> match?(%Post{}, content) end
    filter_selected = :blog
    {:ok, assign(socket, content: content, filter: filter, filter_selected: filter_selected)}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <div class="relative md:grid grid-cols-[20rem,_1fr] max-w-7xl mx-auto">
      <About />
      <div class="font-sans relative px-2 md:px-0 max-h-[90vh] md:overflow-auto">
    <ul class="list-none flex inline-flex gap-2 pt-4 mb-2 w-full pl-2 md:pl-0 md:sticky top-0 z-10 bg-white">
      {#for filter <- [:blog, :projects]}
        <li><button
            type="button"
            :on-click="filter-content"
            :values={filter: filter}
            class={"text-slate-600 px-2", "border-b": @filter_selected == filter}
          >{Phoenix.Naming.humanize(filter)}</button></li>
      {/for}
    </ul>
    {#for item <- Enum.filter(@content, @filter)}
       {#case item}
              {#match %TemporaryHack.Blog.Post{}}
                <Card
                    title={item.title}
                    id={item.id}
                    link={"/blog/#{item.id}"}
                    date={item.date}
                    description={item.description}
                    tags={item.tags}
                />
                {#match %ProjectWithMetadata{}}
                <Card
                    title={item.title}
                    id={item.title}
                    link={item.url}
                    description={item.description}
                    tags={item.tags}
                />
            {/case}
    {/for}
      </div>
    </div>
    """
    end
end
