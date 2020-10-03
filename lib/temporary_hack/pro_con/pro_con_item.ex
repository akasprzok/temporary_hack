defmodule TemporaryHack.ProCon.ProConItem do
  use Ecto.Schema
  import Ecto.Changeset

  @types ~w(pro con)

  schema "pro_con_items" do
    field :name, :string
    field :weight, :integer
    field :type, :string, null: false
    belongs_to :pro_con_list, TemporaryHack.ProCon.ProConList

    timestamps()
  end

  @doc false
  def changeset(pro_con_item, attrs) do
    pro_con_item
    |> cast(attrs, [:name, :weight, :pro_con_list_id, :type])
    |> validate_required([:name, :weight, :pro_con_list_id, :type])
    |> validate_inclusion(:type, @types)
    |> assoc_constraint(:pro_con_list)
  end
end
