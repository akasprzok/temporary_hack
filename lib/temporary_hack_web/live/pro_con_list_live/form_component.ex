defmodule TemporaryHackWeb.ProConListLive.FormComponent do
  use TemporaryHackWeb, :live_component

  alias TemporaryHack.ProCon

  @impl true
  def update(%{pro_con_list: pro_con_list} = assigns, socket) do
    changeset = ProCon.change_pro_con_list(pro_con_list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"pro_con_list" => pro_con_list_params}, socket) do
    changeset =
      socket.assigns.pro_con_list
      |> ProCon.change_pro_con_list(pro_con_list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"pro_con_list" => pro_con_list_params}, socket) do
    save_pro_con_list(socket, socket.assigns.action, pro_con_list_params)
  end

  defp save_pro_con_list(socket, :edit, pro_con_list_params) do
    case ProCon.update_pro_con_list(socket.assigns.pro_con_list, pro_con_list_params) do
      {:ok, _pro_con_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pro con list updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_pro_con_list(socket, :new, pro_con_list_params) do
    case ProCon.create_pro_con_list(pro_con_list_params) do
      {:ok, _pro_con_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pro con list created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
