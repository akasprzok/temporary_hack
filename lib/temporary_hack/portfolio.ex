defmodule TemporaryHack.Portfolio do
  @moduledoc """
  The Admin Portfolio context.
  """

  import Ecto.Query, warn: false
  alias TemporaryHack.Repo

  alias TemporaryHack.Portfolio
  alias TemporaryHack.Portfolio.{Project, ProjectWithMetadata}

  def list_projects() do
    Project
    |> Repo.all()
    |> Enum.map(&ProjectWithMetadata.enrich/1)
  end
end
