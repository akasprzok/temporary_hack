defmodule TemporaryHack.ProConTest do
  use TemporaryHack.DataCase

  alias TemporaryHack.ProCon

  describe "pro_con_lists" do
    alias TemporaryHack.ProCon.ProConList

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def pro_con_list_fixture(attrs \\ %{}) do
      {:ok, pro_con_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProCon.create_pro_con_list()

      pro_con_list
    end

    test "list_pro_con_lists/0 returns all pro_con_lists" do
      pro_con_list = pro_con_list_fixture()
      assert ProCon.list_pro_con_lists() == [pro_con_list]
    end

    test "get_pro_con_list!/1 returns the pro_con_list with given id" do
      pro_con_list = pro_con_list_fixture()
      assert ProCon.get_pro_con_list!(pro_con_list.id) == pro_con_list
    end

    test "create_pro_con_list/1 with valid data creates a pro_con_list" do
      assert {:ok, %ProConList{} = pro_con_list} = ProCon.create_pro_con_list(@valid_attrs)
      assert pro_con_list.title == "some title"
    end

    test "create_pro_con_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProCon.create_pro_con_list(@invalid_attrs)
    end

    test "update_pro_con_list/2 with valid data updates the pro_con_list" do
      pro_con_list = pro_con_list_fixture()

      assert {:ok, %ProConList{} = pro_con_list} =
               ProCon.update_pro_con_list(pro_con_list, @update_attrs)

      assert pro_con_list.title == "some updated title"
    end

    test "update_pro_con_list/2 with invalid data returns error changeset" do
      pro_con_list = pro_con_list_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ProCon.update_pro_con_list(pro_con_list, @invalid_attrs)

      assert pro_con_list == ProCon.get_pro_con_list!(pro_con_list.id)
    end

    test "delete_pro_con_list/1 deletes the pro_con_list" do
      pro_con_list = pro_con_list_fixture()
      assert {:ok, %ProConList{}} = ProCon.delete_pro_con_list(pro_con_list)
      assert_raise Ecto.NoResultsError, fn -> ProCon.get_pro_con_list!(pro_con_list.id) end
    end

    test "change_pro_con_list/1 returns a pro_con_list changeset" do
      pro_con_list = pro_con_list_fixture()
      assert %Ecto.Changeset{} = ProCon.change_pro_con_list(pro_con_list)
    end
  end

  describe "pro_con_items" do
    alias TemporaryHack.ProCon.ProConItem

    @valid_attrs %{name: "some name", weight: 42}
    @update_attrs %{name: "some updated name", weight: 43}
    @invalid_attrs %{name: nil, weight: nil}

    def pro_con_item_fixture(attrs \\ %{}) do
      {:ok, pro_con_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProCon.create_pro_con_item()

      pro_con_item
    end

    test "list_pro_con_items/0 returns all pro_con_items" do
      pro_con_item = pro_con_item_fixture()
      assert ProCon.list_pro_con_items() == [pro_con_item]
    end

    test "get_pro_con_item!/1 returns the pro_con_item with given id" do
      pro_con_item = pro_con_item_fixture()
      assert ProCon.get_pro_con_item!(pro_con_item.id) == pro_con_item
    end

    test "create_pro_con_item/1 with valid data creates a pro_con_item" do
      assert {:ok, %ProConItem{} = pro_con_item} = ProCon.create_pro_con_item(@valid_attrs)
      assert pro_con_item.name == "some name"
      assert pro_con_item.weight == 42
    end

    test "create_pro_con_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProCon.create_pro_con_item(@invalid_attrs)
    end

    test "update_pro_con_item/2 with valid data updates the pro_con_item" do
      pro_con_item = pro_con_item_fixture()
      assert {:ok, %ProConItem{} = pro_con_item} = ProCon.update_pro_con_item(pro_con_item, @update_attrs)
      assert pro_con_item.name == "some updated name"
      assert pro_con_item.weight == 43
    end

    test "update_pro_con_item/2 with invalid data returns error changeset" do
      pro_con_item = pro_con_item_fixture()
      assert {:error, %Ecto.Changeset{}} = ProCon.update_pro_con_item(pro_con_item, @invalid_attrs)
      assert pro_con_item == ProCon.get_pro_con_item!(pro_con_item.id)
    end

    test "delete_pro_con_item/1 deletes the pro_con_item" do
      pro_con_item = pro_con_item_fixture()
      assert {:ok, %ProConItem{}} = ProCon.delete_pro_con_item(pro_con_item)
      assert_raise Ecto.NoResultsError, fn -> ProCon.get_pro_con_item!(pro_con_item.id) end
    end

    test "change_pro_con_item/1 returns a pro_con_item changeset" do
      pro_con_item = pro_con_item_fixture()
      assert %Ecto.Changeset{} = ProCon.change_pro_con_item(pro_con_item)
    end
  end
end
