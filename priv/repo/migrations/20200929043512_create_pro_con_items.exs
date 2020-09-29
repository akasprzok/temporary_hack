defmodule TemporaryHack.Repo.Migrations.CreateProConItems do
  use Ecto.Migration

  def change do
    create table(:pro_con_items) do
      add :name, :string
      add :weight, :integer
      add :list_id, references(:pro_con_lists)
    end
  end
end
