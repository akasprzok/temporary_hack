defmodule TemporaryHackWeb.Components.Tag do
  use Surface.Component
  slot default, required: true

  def render(assigns) do
    ~F"""
    <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2">
      <#slot />
    </span>
    """
  end
end
