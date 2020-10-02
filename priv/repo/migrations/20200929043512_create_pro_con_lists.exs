defmodule TemporaryHack.Repo.Migrations.CreateProConLists do
  use Ecto.Migration

  def change do
    create table(:pro_con_lists) do
      add :title, :string
      timestamps()
    end
  end
end
