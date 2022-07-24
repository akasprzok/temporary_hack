defmodule TemporaryHack.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :user, :string
      add :repo, :string

      timestamps()
    end

    create unique_index(:projects, [:user, :repo])
  end
end
