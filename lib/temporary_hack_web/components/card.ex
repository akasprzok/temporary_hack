defmodule TemporaryHackWeb.Components.Card do
  @moduledoc """
  A surface component for a card on the main page.
  """
  use Surface.Component

  alias Surface.Components.Link

  prop title, :string
  prop date, :datetime
  prop id, :string
  prop description, :string
  prop link, :string

  def render(assigns) do
    ~F"""
    <div id={@id} class="flex flex-col justify-start">
      <!--
      <div class="inline-flex justify-between">
        <h2 class="inline-flex justify-start font-bold text-xl mb-2">
          <Link label={@title} to={"/blog/#{@id}"} />
        </h2>

        <p class="inline-flex justify-end text-gray-700">
          <time>{@date}</time>
        </p>
      </div>
      -->

      {@description}

        <!--
      <div class="px-6 pt-4 pb-2">
    <%= for tag <- post.tags do %>
      <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%=tag%></span>
    <% end %>
      </div>
    -->
    </div>
    """
  end
end
