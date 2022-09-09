defmodule TemporaryHack.Portfolio do
  @moduledoc """
  The Admin Portfolio context.
  """

  alias TemporaryHack.Portfolio.ProjectWithMetadata

  def list_projects do
    Application.get_env(:temporary_hack, :projects, [])
    |> Enum.map(&ProjectWithMetadata.enrich/1)
  end
end
