defmodule TemporaryHack.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :github_repo, :string

      timestamps()
    end
  end
end
