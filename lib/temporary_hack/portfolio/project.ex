defmodule TemporaryHack.Portfolio.Project do
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
