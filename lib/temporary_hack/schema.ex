defmodule TemporaryHack.Schema do
  @moduledoc """
  The base schema.
  Primary adjustment is using a UUID for the primary key.
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @derive {Phoenix.Param, key: :id}
    end
  end
end
