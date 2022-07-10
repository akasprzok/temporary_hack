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
  end
end
