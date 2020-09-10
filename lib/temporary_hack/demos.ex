defmodule TemporaryHack.Demos do
  @moduledoc """
  The Demos context.
  """

  import Ecto.Query, warn: false
  alias TemporaryHack.Repo

  alias TemporaryHack.Demos.Clicker

  @doc """
  Returns the list of clickers.

  ## Examples

      iex> list_clickers()
      [%Clicker{}, ...]

  """
  def list_clickers do
    Repo.all(Clicker)
  end

  @doc """
  Gets a single clicker.

  Raises `Ecto.NoResultsError` if the Clicker does not exist.

  ## Examples

      iex> get_clicker!(123)
      %Clicker{}

      iex> get_clicker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clicker!(id), do: Repo.get!(Clicker, id)

  @doc """
  Creates a clicker.

  ## Examples

      iex> create_clicker(%{field: value})
      {:ok, %Clicker{}}

      iex> create_clicker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clicker(attrs \\ %{}) do
    %Clicker{}
    |> Clicker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clicker.

  ## Examples

      iex> update_clicker(clicker, %{field: new_value})
      {:ok, %Clicker{}}

      iex> update_clicker(clicker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clicker(%Clicker{} = clicker, attrs) do
    clicker
    |> Clicker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clicker.

  ## Examples

      iex> delete_clicker(clicker)
      {:ok, %Clicker{}}

      iex> delete_clicker(clicker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clicker(%Clicker{} = clicker) do
    Repo.delete(clicker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clicker changes.

  ## Examples

      iex> change_clicker(clicker)
      %Ecto.Changeset{data: %Clicker{}}

  """
  def change_clicker(%Clicker{} = clicker, attrs \\ %{}) do
    Clicker.changeset(clicker, attrs)
  end
end
