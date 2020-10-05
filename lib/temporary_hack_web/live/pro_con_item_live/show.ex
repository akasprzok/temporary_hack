defmodule TemporaryHackWeb.ProConItemLive.Show do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.ProCon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pro_con_item, ProCon.get_pro_con_item!(id))}
  end

  defp page_title(:show), do: "Show Pro con item"
  defp page_title(:edit), do: "Edit Pro con item"
end
