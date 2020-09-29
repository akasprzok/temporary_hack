defmodule TemporaryHack.ProCon.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pro_con_items" do
    field :name, :string
    field :weight, :integer
    belongs_to :list, TemporaryHack.ProCon.List

    timestamps()
  end

  @doc false
  def changeset(pro_con_item, attrs) do
    pro_con_item
    |> cast(attrs, [:name, weight])
    |> validate_required([:name, weight])
  end
end
