defmodule TemporaryHack.FrontpageTest do
  use TemporaryHack.DataCase

  alias TemporaryHack.Frontpage

  describe "tag_lines" do
    alias TemporaryHack.Frontpage.Tagline

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def tagline_fixture(attrs \\ %{}) do
      {:ok, tagline} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Frontpage.create_tagline()

      tagline
    end

    test "list_tag_lines/0 returns all tag_lines" do
      tagline = tagline_fixture()
      assert Frontpage.list_tag_lines() == [tagline]
    end

    test "get_tagline!/1 returns the tagline with given id" do
      tagline = tagline_fixture()
      assert Frontpage.get_tagline!(tagline.id) == tagline
    end

    test "create_tagline/1 with valid data creates a tagline" do
      assert {:ok, %Tagline{} = tagline} = Frontpage.create_tagline(@valid_attrs)
      assert tagline.text == "some text"
    end

    test "create_tagline/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frontpage.create_tagline(@invalid_attrs)
    end

    test "update_tagline/2 with valid data updates the tagline" do
      tagline = tagline_fixture()
      assert {:ok, %Tagline{} = tagline} = Frontpage.update_tagline(tagline, @update_attrs)
      assert tagline.text == "some updated text"
    end

    test "update_tagline/2 with invalid data returns error changeset" do
      tagline = tagline_fixture()
      assert {:error, %Ecto.Changeset{}} = Frontpage.update_tagline(tagline, @invalid_attrs)
      assert tagline == Frontpage.get_tagline!(tagline.id)
    end

    test "delete_tagline/1 deletes the tagline" do
      tagline = tagline_fixture()
      assert {:ok, %Tagline{}} = Frontpage.delete_tagline(tagline)
      assert_raise Ecto.NoResultsError, fn -> Frontpage.get_tagline!(tagline.id) end
    end

    test "change_tagline/1 returns a tagline changeset" do
      tagline = tagline_fixture()
      assert %Ecto.Changeset{} = Frontpage.change_tagline(tagline)
    end
  end
end
