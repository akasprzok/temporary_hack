defmodule TemporaryHack.Portfolio do
  @moduledoc """
  The Admin Portfolio context.
  """

  import Ecto.Query, warn: false
  alias TemporaryHack.Repo

  alias TemporaryHack.Portfolio.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
    |> Enum.map(&enrich/1)
  end

  defp enrich(project) do
    project
  end

  defp hex_docs_url(github_repo) do
    "https://hexdocs.pm/#{github_repo}"
  end
end
