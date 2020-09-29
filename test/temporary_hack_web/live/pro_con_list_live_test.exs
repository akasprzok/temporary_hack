defmodule TemporaryHackWeb.ProConListLiveTest do
  use TemporaryHackWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TemporaryHack.ProCon

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp fixture(:pro_con_list) do
    {:ok, pro_con_list} = ProCon.create_pro_con_list(@create_attrs)
    pro_con_list
  end

  defp create_pro_con_list(_) do
    pro_con_list = fixture(:pro_con_list)
    %{pro_con_list: pro_con_list}
  end

  describe "Index" do
    setup [:create_pro_con_list]

    test "lists all pro_con_lists", %{conn: conn, pro_con_list: pro_con_list} do
      {:ok, _index_live, html} = live(conn, Routes.pro_con_list_index_path(conn, :index))

      assert html =~ "Listing Pro con lists"
      assert html =~ pro_con_list.title
    end

    test "saves new pro_con_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.pro_con_list_index_path(conn, :index))

      assert index_live |> element("a", "New Pro con list") |> render_click() =~
               "New Pro con list"

      assert_patch(index_live, Routes.pro_con_list_index_path(conn, :new))

      assert index_live
             |> form("#pro_con_list-form", pro_con_list: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pro_con_list-form", pro_con_list: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_con_list_index_path(conn, :index))

      assert html =~ "Pro con list created successfully"
      assert html =~ "some title"
    end

    test "updates pro_con_list in listing", %{conn: conn, pro_con_list: pro_con_list} do
      {:ok, index_live, _html} = live(conn, Routes.pro_con_list_index_path(conn, :index))

      assert index_live |> element("#pro_con_list-#{pro_con_list.id} a", "Edit") |> render_click() =~
               "Edit Pro con list"

      assert_patch(index_live, Routes.pro_con_list_index_path(conn, :edit, pro_con_list))

      assert index_live
             |> form("#pro_con_list-form", pro_con_list: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pro_con_list-form", pro_con_list: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_con_list_index_path(conn, :index))

      assert html =~ "Pro con list updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes pro_con_list in listing", %{conn: conn, pro_con_list: pro_con_list} do
      {:ok, index_live, _html} = live(conn, Routes.pro_con_list_index_path(conn, :index))

      assert index_live
             |> element("#pro_con_list-#{pro_con_list.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#pro_con_list-#{pro_con_list.id}")
    end
  end

  describe "Show" do
    setup [:create_pro_con_list]

    test "displays pro_con_list", %{conn: conn, pro_con_list: pro_con_list} do
      {:ok, _show_live, html} =
        live(conn, Routes.pro_con_list_show_path(conn, :show, pro_con_list))

      assert html =~ "Show Pro con list"
      assert html =~ pro_con_list.title
    end

    test "updates pro_con_list within modal", %{conn: conn, pro_con_list: pro_con_list} do
      {:ok, show_live, _html} =
        live(conn, Routes.pro_con_list_show_path(conn, :show, pro_con_list))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pro con list"

      assert_patch(show_live, Routes.pro_con_list_show_path(conn, :edit, pro_con_list))

      assert show_live
             |> form("#pro_con_list-form", pro_con_list: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#pro_con_list-form", pro_con_list: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.pro_con_list_show_path(conn, :show, pro_con_list))

      assert html =~ "Pro con list updated successfully"
      assert html =~ "some updated title"
    end
  end
end
