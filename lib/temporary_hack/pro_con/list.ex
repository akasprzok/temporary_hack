defmodule TemporaryHack.ProCon.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pro_con_lists" do
    field :title, :string
    has_many :pros, TemporaryHack.ProCon.Item
    has_many :cons, TemporaryHack.ProCon.Item

    timestamps()
  end

  @doc false
  def changeset(list, attrs \\ %{}) do
    list
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:pros, required: false)
    |> cast_assoc(:cons, required: false)
  end
end
