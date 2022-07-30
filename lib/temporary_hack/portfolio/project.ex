defmodule TemporaryHack.Portfolio.Project do
  @moduledoc """
  A project, defined by its Github repo.

  The aim here is to keep the amount of data stored
  in the DB as small as possible, and to gather additional
  information from APIs such as Github, Hex, crates.io, etc.
  using `TemporaryHack.Portfolio.ProjectWithMetadata`.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :user, :string, default: "akasprzok"
    field :repo, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:user, :repo])
    |> validate_required([:repo])
    |> unique_constraint(:user)
  end
end
