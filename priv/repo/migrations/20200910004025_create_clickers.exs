defmodule TemporaryHack.Repo.Migrations.CreateClickers do
  use Ecto.Migration

  def change do
    create table(:clickers) do
      add :clicks, :integer

      timestamps()
    end
  end
end
