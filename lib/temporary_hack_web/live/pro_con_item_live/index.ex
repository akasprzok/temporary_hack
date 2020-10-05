defmodule TemporaryHackWeb.ProConItemLive.Index do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.ProCon
  alias TemporaryHack.ProCon.ProConItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :pro_con_items, list_pro_con_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pro con item")
    |> assign(:pro_con_item, ProCon.get_pro_con_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pro con item")
    |> assign(:pro_con_item, %ProConItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pro con items")
    |> assign(:pro_con_item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pro_con_item = ProCon.get_pro_con_item!(id)
    {:ok, _} = ProCon.delete_pro_con_item(pro_con_item)

    {:noreply, assign(socket, :pro_con_items, list_pro_con_items())}
  end

  defp list_pro_con_items do
    ProCon.list_pro_con_items()
  end
end
