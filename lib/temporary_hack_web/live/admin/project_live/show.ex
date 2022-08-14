defmodule TemporaryHackWeb.Admin.ProjectLive.Show do
  @moduledoc false
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.Admin.Portfolio

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:project, Portfolio.get_project!(id))}
  end

  defp page_title(:show), do: "Show Project"
  defp page_title(:edit), do: "Edit Project"
end
