defmodule TemporaryHack.Demos.Clicker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clickers" do
    field :clicks, :integer

    timestamps()
  end

  @doc false
  def changeset(clicker, attrs) do
    clicker
    |> cast(attrs, [:clicks])
    |> validate_required([:clicks])
  end
end
