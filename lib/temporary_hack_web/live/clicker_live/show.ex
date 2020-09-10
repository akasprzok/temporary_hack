defmodule TemporaryHackWeb.ClickerLive.Show do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.Demos

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:clicker, Demos.get_clicker!(id))}
  end

  defp page_title(:show), do: "Show Clicker"
  defp page_title(:edit), do: "Edit Clicker"
end
