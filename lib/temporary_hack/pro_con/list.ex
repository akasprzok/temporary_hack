defmodule TemporaryHack.ProCon.ProConList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pro_con_lists" do
    field :title, :string
    has_many :pro_con_items, TemporaryHack.ProCon.ProConItem

    timestamps()
  end

  @doc false
  def changeset(list, attrs \\ %{}) do
    list
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:pro_con_items, required: false)
  end
end
