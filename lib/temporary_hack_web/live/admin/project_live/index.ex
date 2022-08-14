defmodule TemporaryHackWeb.Admin.ProjectLive.Index do
  @moduledoc false

  use TemporaryHackWeb, :live_view

  alias TemporaryHack.Admin.Portfolio
  alias TemporaryHack.Portfolio.Project

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :projects, list_projects())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Project")
    |> assign(:project, Portfolio.get_project!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Project")
    |> assign(:project, %Project{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Projects")
    |> assign(:project, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    project = Portfolio.get_project!(id)
    {:ok, _} = Portfolio.delete_project(project)

    {:noreply, assign(socket, :projects, list_projects())}
  end

  defp list_projects do
    Portfolio.list_projects()
  end
end
