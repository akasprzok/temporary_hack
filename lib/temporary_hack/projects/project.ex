defmodule TemporaryHack.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :github_repo, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:github_repo])
    |> validate_required([:github_repo])
  end
end
