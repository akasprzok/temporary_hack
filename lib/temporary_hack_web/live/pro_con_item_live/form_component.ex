defmodule TemporaryHackWeb.ProConItemLive.FormComponent do
  use TemporaryHackWeb, :live_component

  alias TemporaryHack.ProCon

  @impl true
  def update(%{pro_con_item: pro_con_item} = assigns, socket) do
    changeset = ProCon.change_pro_con_item(pro_con_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"pro_con_item" => pro_con_item_params}, socket) do
    changeset =
      socket.assigns.pro_con_item
      |> ProCon.change_pro_con_item(pro_con_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"pro_con_item" => pro_con_item_params}, socket) do
    save_pro_con_item(socket, socket.assigns.action, pro_con_item_params)
  end

  defp save_pro_con_item(socket, :edit, pro_con_item_params) do
    case ProCon.update_pro_con_item(socket.assigns.pro_con_item, pro_con_item_params) do
      {:ok, _pro_con_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pro con item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_pro_con_item(socket, :new, pro_con_item_params) do
    case ProCon.create_pro_con_item(pro_con_item_params) do
      {:ok, _pro_con_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pro con item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
