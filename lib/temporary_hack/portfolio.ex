defmodule TemporaryHack.Portfolio do
  @moduledoc """
  The Admin Portfolio context.
  """

  alias TemporaryHack.Portfolio.Project

  def list_projects do
    :temporary_hack
    |> Application.get_env(:projects, [])
    |> Enum.map(&Project.enrich/1)
  end
end
