defmodule TemporaryHack.DemosTest do
  use TemporaryHack.DataCase

  alias TemporaryHack.Demos

  describe "clickers" do
    alias TemporaryHack.Demos.Clicker

    @valid_attrs %{clicks: 42}
    @update_attrs %{clicks: 43}
    @invalid_attrs %{clicks: nil}

    def clicker_fixture(attrs \\ %{}) do
      {:ok, clicker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Demos.create_clicker()

      clicker
    end

    test "list_clickers/0 returns all clickers" do
      clicker = clicker_fixture()
      assert Demos.list_clickers() == [clicker]
    end

    test "get_clicker!/1 returns the clicker with given id" do
      clicker = clicker_fixture()
      assert Demos.get_clicker!(clicker.id) == clicker
    end

    test "create_clicker/1 with valid data creates a clicker" do
      assert {:ok, %Clicker{} = clicker} = Demos.create_clicker(@valid_attrs)
      assert clicker.clicks == 42
    end

    test "create_clicker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Demos.create_clicker(@invalid_attrs)
    end

    test "update_clicker/2 with valid data updates the clicker" do
      clicker = clicker_fixture()
      assert {:ok, %Clicker{} = clicker} = Demos.update_clicker(clicker, @update_attrs)
      assert clicker.clicks == 43
    end

    test "update_clicker/2 with invalid data returns error changeset" do
      clicker = clicker_fixture()
      assert {:error, %Ecto.Changeset{}} = Demos.update_clicker(clicker, @invalid_attrs)
      assert clicker == Demos.get_clicker!(clicker.id)
    end

    test "delete_clicker/1 deletes the clicker" do
      clicker = clicker_fixture()
      assert {:ok, %Clicker{}} = Demos.delete_clicker(clicker)
      assert_raise Ecto.NoResultsError, fn -> Demos.get_clicker!(clicker.id) end
    end

    test "change_clicker/1 returns a clicker changeset" do
      clicker = clicker_fixture()
      assert %Ecto.Changeset{} = Demos.change_clicker(clicker)
    end
  end
end
