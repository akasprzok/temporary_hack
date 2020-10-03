defmodule TemporaryHackWeb.ProConListLive.Show do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.ProCon

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    pro_con_list = ProCon.get_pro_con_list!(id) |> IO.inspect()
    pros = ProCon.get_pros(pro_con_list)
    cons = ProCon.get_cons(pro_con_list)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pro_con_list, pro_con_list)
     |> assign(:pros, pros)
     |> assign(:cons, cons)}
  end

  defp page_title(:show), do: "Show Pro con list"
  defp page_title(:edit), do: "Edit Pro con list"
end
