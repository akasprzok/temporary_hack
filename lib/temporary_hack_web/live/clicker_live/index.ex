defmodule TemporaryHackWeb.ClickerLive.Index do
  use TemporaryHackWeb, :live_view

  alias TemporaryHack.Demos
  alias TemporaryHack.Demos.Clicker

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :clickers, list_clickers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Clicker")
    |> assign(:clicker, Demos.get_clicker!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Clicker")
    |> assign(:clicker, %Clicker{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Clickers")
    |> assign(:clicker, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    clicker = Demos.get_clicker!(id)
    {:ok, _} = Demos.delete_clicker(clicker)

    {:noreply, assign(socket, :clickers, list_clickers())}
  end

  defp list_clickers do
    Demos.list_clickers()
  end
end
