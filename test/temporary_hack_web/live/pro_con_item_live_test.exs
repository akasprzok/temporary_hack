defmodule TemporaryHackWeb.ProConItemLiveTest do
  use TemporaryHackWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TemporaryHack.ProCon

  @create_attrs %{name: "some name", weight: 42}
  @update_attrs %{name: "some updated name", weight: 43}
  @invalid_attrs %{name: nil, weight: nil}

  defp fixture(:pro_con_item) do
    {:ok, pro_con_item} = ProCon.create_pro_con_item(@create_attrs)
    pro_con_item
  end

  defp create_pro_con_item(_) do
    pro_con_item = fixture(:pro_con_item)
    %{pro_con_item: pro_con_item}
  end

  describe "Index" do
    setup [:create_pro_con_item]

    test "lists all pro_con_items", %{conn: conn, pro_con_item: pro_con_item} do
      {:ok, _index_live, html} = live(conn, Routes.pro_con_item_index_path(conn, :index))

      assert html =~ "Listing Pro con items"
      assert html =~ pro_con_item.name
    end

    test "saves new pro_con_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.pro_con_item_index_path(conn, :index))

      assert index_live |> element("a", "New Pro con item") |> render_click() =~
               "New Pro con item"

      assert_patch(index_live, Routes.pro_con_item_index_path(conn, :new))

      assert index_live
             |> form("#pro_con_item-form", pro_con_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pro_con_item-form", pro_con_item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_con_item_index_path(conn, :index))

      assert html =~ "Pro con item created successfully"
      assert html =~ "some name"
    end

    test "updates pro_con_item in listing", %{conn: conn, pro_con_item: pro_con_item} do
      {:ok, index_live, _html} = live(conn, Routes.pro_con_item_index_path(conn, :index))

      assert index_live |> element("#pro_con_item-#{pro_con_item.id} a", "Edit") |> render_click() =~
               "Edit Pro con item"

      assert_patch(index_live, Routes.pro_con_item_index_path(conn, :edit, pro_con_item))

      assert index_live
             |> form("#pro_con_item-form", pro_con_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pro_con_item-form", pro_con_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_con_item_index_path(conn, :index))

      assert html =~ "Pro con item updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes pro_con_item in listing", %{conn: conn, pro_con_item: pro_con_item} do
      {:ok, index_live, _html} = live(conn, Routes.pro_con_item_index_path(conn, :index))

      assert index_live |> element("#pro_con_item-#{pro_con_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pro_con_item-#{pro_con_item.id}")
    end
  end

  describe "Show" do
    setup [:create_pro_con_item]

    test "displays pro_con_item", %{conn: conn, pro_con_item: pro_con_item} do
      {:ok, _show_live, html} = live(conn, Routes.pro_con_item_show_path(conn, :show, pro_con_item))

      assert html =~ "Show Pro con item"
      assert html =~ pro_con_item.name
    end

    test "updates pro_con_item within modal", %{conn: conn, pro_con_item: pro_con_item} do
      {:ok, show_live, _html} = live(conn, Routes.pro_con_item_show_path(conn, :show, pro_con_item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pro con item"

      assert_patch(show_live, Routes.pro_con_item_show_path(conn, :edit, pro_con_item))

      assert show_live
             |> form("#pro_con_item-form", pro_con_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#pro_con_item-form", pro_con_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_con_item_show_path(conn, :show, pro_con_item))

      assert html =~ "Pro con item updated successfully"
      assert html =~ "some updated name"
    end
  end
end
