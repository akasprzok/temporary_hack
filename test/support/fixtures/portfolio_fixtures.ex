defmodule TemporaryHack.PortfolioFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TemporaryHack.Portfolio` context.
  """

  alias TemporaryHack.Admin.Portfolio

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        github_repo: "temporary_hack"
      })
      |> Portfolio.create_project()

    project
  end
end
