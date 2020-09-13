defmodule TemporaryHack.Frontpage do
  @moduledoc """
  The Frontpage context.
  """

  import Ecto.Query, warn: false
  alias TemporaryHack.Repo

  alias TemporaryHack.Frontpage.Tagline

  @doc """
  Returns the list of tag_lines.

  ## Examples

      iex> list_tag_lines()
      [%Tagline{}, ...]

  """
  def list_tag_lines do
    Repo.all(Tagline)
  end

  @doc """
  Gets a single tagline.

  Raises `Ecto.NoResultsError` if the Tagline does not exist.

  ## Examples

      iex> get_tagline!(123)
      %Tagline{}

      iex> get_tagline!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tagline!(id), do: Repo.get!(Tagline, id)

  @doc """
  Creates a tagline.

  ## Examples

      iex> create_tagline(%{field: value})
      {:ok, %Tagline{}}

      iex> create_tagline(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tagline(attrs \\ %{}) do
    %Tagline{}
    |> Tagline.changeset(attrs)
    |> Repo.insert()
  end

  def create_tagline!(attrs \\ %{}) do
    %Tagline{}
    |> Tagline.changeset(attrs)
    |> Repo.insert!()
  end


  @doc """
  Updates a tagline.

  ## Examples

      iex> update_tagline(tagline, %{field: new_value})
      {:ok, %Tagline{}}

      iex> update_tagline(tagline, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tagline(%Tagline{} = tagline, attrs) do
    tagline
    |> Tagline.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tagline.

  ## Examples

      iex> delete_tagline(tagline)
      {:ok, %Tagline{}}

      iex> delete_tagline(tagline)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tagline(%Tagline{} = tagline) do
    Repo.delete(tagline)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tagline changes.

  ## Examples

      iex> change_tagline(tagline)
      %Ecto.Changeset{data: %Tagline{}}

  """
  def change_tagline(%Tagline{} = tagline, attrs \\ %{}) do
    Tagline.changeset(tagline, attrs)
  end
end
