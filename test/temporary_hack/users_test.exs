defmodule TemporaryHack.UsersTest do
  use TemporaryHack.DataCase

  alias TemporaryHack.{Repo, Users, Users.User}

  @valid_params %{
    email: "test@example.com",
    password: "secret1234",
    password_confirmation: "secret1234"
  }

  test "create_admin!/2" do
    user = Users.create_admin!(@valid_params)
    assert user.role == "admin"
  end

  test "is_admin?/1" do
    refute Users.is_admin?(nil)

    assert {:ok, user} = Repo.insert(User.changeset(%User{}, @valid_params))
    refute Users.is_admin?(user)

    admin = Users.create_admin!(%{@valid_params | email: "test2@example.com"})
    assert Users.is_admin?(admin)
  end
end
