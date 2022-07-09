defmodule TemporaryHack.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TemporaryHack.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        github_repo: "some github_repo"
      })
      |> TemporaryHack.Projects.create_project()

    project
  end
end
