defmodule TemporaryHackWeb.ProConListLive.Index do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.ProCon
  alias TemporaryHack.ProCon.ProConList

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :pro_con_lists, list_pro_con_lists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pro con list")
    |> assign(:pro_con_list, ProCon.get_pro_con_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pro con list")
    |> assign(:pro_con_list, %ProConList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pro con lists")
    |> assign(:pro_con_list, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pro_con_list = ProCon.get_pro_con_list!(id)
    {:ok, _} = ProCon.delete_pro_con_list(pro_con_list)

    {:noreply, assign(socket, :pro_con_lists, list_pro_con_lists())}
  end

  defp list_pro_con_lists do
    ProCon.list_pro_con_lists()
  end
end
