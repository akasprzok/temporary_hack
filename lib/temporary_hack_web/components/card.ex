defmodule TemporaryHackWeb.Components.Card do
  @moduledoc """
  A surface component for a card on the main page.
  """
  use Surface.Component

  alias TemporaryHackWeb.Components.Tag
  alias Surface.Components.Link

  prop title, :string, required: true
  prop date, :datetime
  prop id, :string, required: true
  prop description, :string
  prop link, :string, required: true
  prop tags, :list, default: []

  def render(assigns) do
    ~F"""
    <div id={@id} class="rounded shadow-lg m-2 p-2">
      <div class="flex justify-between">
        <h2 class="flex justify-start font-bold text-xl mb-2">
          <Link label={@title} to={"/blog/#{@id}"} />
        </h2>

        <p class="flex justify-end text-gray-700">
          <time>{@date}</time>
        </p>
      </div>

      {@description}

      <div class="px-6 pt-4 pb-2">
        {#for tag <- @tags}
          <Tag>{tag}</Tag>
        {/for}
      </div>
    </div>
    """
  end
end
