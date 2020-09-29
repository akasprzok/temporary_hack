defmodule TemporaryHack.ProCon do
  @moduledoc """
  The ProCon context.
  """

  import Ecto.Query, warn: false
  alias TemporaryHack.Repo

  alias TemporaryHack.ProCon.ProConList

  @doc """
  Returns the list of pro_con_lists.

  ## Examples

      iex> list_pro_con_lists()
      [%ProConList{}, ...]

  """
  def list_pro_con_lists do
    Repo.all(ProConList)
  end

  @doc """
  Gets a single pro_con_list.

  Raises `Ecto.NoResultsError` if the Pro con list does not exist.

  ## Examples

      iex> get_pro_con_list!(123)
      %ProConList{}

      iex> get_pro_con_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pro_con_list!(id), do: Repo.get!(ProConList, id)

  @doc """
  Creates a pro_con_list.

  ## Examples

      iex> create_pro_con_list(%{field: value})
      {:ok, %ProConList{}}

      iex> create_pro_con_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pro_con_list(attrs \\ %{}) do
    %ProConList{}
    |> ProConList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pro_con_list.

  ## Examples

      iex> update_pro_con_list(pro_con_list, %{field: new_value})
      {:ok, %ProConList{}}

      iex> update_pro_con_list(pro_con_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pro_con_list(%ProConList{} = pro_con_list, attrs) do
    pro_con_list
    |> ProConList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pro_con_list.

  ## Examples

      iex> delete_pro_con_list(pro_con_list)
      {:ok, %ProConList{}}

      iex> delete_pro_con_list(pro_con_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pro_con_list(%ProConList{} = pro_con_list) do
    Repo.delete(pro_con_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pro_con_list changes.

  ## Examples

      iex> change_pro_con_list(pro_con_list)
      %Ecto.Changeset{data: %ProConList{}}

  """
  def change_pro_con_list(%ProConList{} = pro_con_list, attrs \\ %{}) do
    ProConList.changeset(pro_con_list, attrs)
  end
end
