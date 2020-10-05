defmodule TemporaryHack.ProCon.ProConItem do
  use Ecto.Schema
  import Ecto.Changeset

  @types ~w(pro con)

  schema "pro_con_items" do
    field :name, :string, null: false
    field :weight, :integer, default: 0
    field :type, :string, null: false
    belongs_to :pro_con_list, TemporaryHack.ProCon.ProConList

    timestamps()
  end

  @doc false
  def changeset(pro_con_item, attrs) do
    pro_con_item
    |> cast(attrs, [:name, :weight, :type, :pro_con_list_id])
    |> validate_required([:name, :pro_con_list_id, :type])
    |> validate_inclusion(:type, @types)
    |> assoc_constraint(:pro_con_list)
  end
end
