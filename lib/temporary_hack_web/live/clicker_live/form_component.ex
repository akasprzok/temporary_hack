defmodule TemporaryHackWeb.ClickerLive.FormComponent do
  use TemporaryHackWeb, :live_component

  alias TemporaryHack.Demos

  @impl true
  def update(%{clicker: clicker} = assigns, socket) do
    changeset = Demos.change_clicker(clicker)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"clicker" => clicker_params}, socket) do
    changeset =
      socket.assigns.clicker
      |> Demos.change_clicker(clicker_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"clicker" => clicker_params}, socket) do
    save_clicker(socket, socket.assigns.action, clicker_params)
  end

  defp save_clicker(socket, :edit, clicker_params) do
    case Demos.update_clicker(socket.assigns.clicker, clicker_params) do
      {:ok, _clicker} ->
        {:noreply,
         socket
         |> put_flash(:info, "Clicker updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_clicker(socket, :new, clicker_params) do
    case Demos.create_clicker(clicker_params) do
      {:ok, _clicker} ->
        {:noreply,
         socket
         |> put_flash(:info, "Clicker created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
