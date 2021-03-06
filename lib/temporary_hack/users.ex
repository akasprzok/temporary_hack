defmodule TemporaryHack.Users do
  @moduledoc """
  User stuff.
  """
  alias TemporaryHack.{Repo, Users.User}

  @type t :: %User{}

  def create_admin!(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert!()
  end

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "user"})
    |> Repo.insert!()
  end

  @spec is_admin?(t()) :: boolean()
  def is_admin?(%{role: "admin"}), do: true
  def is_admin?(_any), do: false
end
