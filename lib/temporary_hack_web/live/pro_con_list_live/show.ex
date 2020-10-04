defmodule TemporaryHackWeb.ProConListLive.Show do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.ProCon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    pro_con_list = ProCon.get_pro_con_list!(id) |> IO.inspect()

    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:pro_con_list, pro_con_list)
  end

  defp page_title(:show), do: "Show Pro con list"
  defp page_title(:edit), do: "Edit Pro con list"
end
