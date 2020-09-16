defmodule TemporaryHack.Frontpage.Tagline do
  @moduledoc """
  Schema for taglines.  Currently used on the landing page.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "tag_lines" do
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(tagline, attrs) do
    tagline
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
