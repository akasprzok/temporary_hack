defmodule TemporaryHack.Repo.Migrations.CreateProConItems do
  use Ecto.Migration

  def change do
    create table(:pro_con_items) do
      add :name, :string
      add :weight, :integer
      add :type, :string
      add :pro_con_list_id, references(:pro_con_lists)

      timestamps()
    end
  end
end
