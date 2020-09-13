defmodule TemporaryHack.Repo.Migrations.CreateTagLines do
  use Ecto.Migration

  def change do
    create table(:tag_lines) do
      add :text, :string

      timestamps()
    end

  end
end
