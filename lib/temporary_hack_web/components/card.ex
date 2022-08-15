defmodule TemporaryHackWeb.Components.Card do
  use Surface.Component

  prop title, :string
  prop date, :datetime
  prop id, :string
  prop description, :string

  def render(assigns) do
    ~F"""
    <div id={@id} class="rounded w-full shadow-lg bg-blue-100 m-2 p-2">
      <div class="flex justify-between">
        <h2 class="flex justify-start font-bold text-xl mb-2">
          {@title}
          <!-- <%= link post.title, to: Routes.blog_path(@conn, :show, post)%> -->
        </h2>

        <p class="flex justify-end text-gray-700">
          <time>{@date}</time>
        </p>
      </div>

      {@description}

      <div class="px-6 pt-4 pb-2">
        <!--
    <%= for tag <- post.tags do %>
      <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%=tag%></span>
    <% end %>
    -->
      </div>
    </div>
    """
  end
end
