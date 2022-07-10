defmodule TemporaryHack.Portfolio.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :github_repo, :string
    field :hex, :boolean, default: false
    field :hex_docs, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:github_repo, :hex, :hex_docs])
    |> validate_required([:github_repo])
    |> unique_constraint(:github_repo)
  end
end
