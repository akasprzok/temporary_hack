defmodule TemporaryHack.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :github_repo, :string
      add :hex, :boolean
      add :hex_docs, :boolean

      timestamps()
    end

    create unique_index(:projects, [:github_repo])
  end
end
