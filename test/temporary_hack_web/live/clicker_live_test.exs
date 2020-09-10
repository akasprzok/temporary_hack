defmodule TemporaryHackWeb.ClickerLiveTest do
  use TemporaryHackWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TemporaryHack.Demos

  @create_attrs %{clicks: 42}
  @update_attrs %{clicks: 43}
  @invalid_attrs %{clicks: nil}

  defp fixture(:clicker) do
    {:ok, clicker} = Demos.create_clicker(@create_attrs)
    clicker
  end

  defp create_clicker(_) do
    clicker = fixture(:clicker)
    %{clicker: clicker}
  end

  describe "Index" do
    setup [:create_clicker]

    test "lists all clickers", %{conn: conn, clicker: clicker} do
      {:ok, _index_live, html} = live(conn, Routes.clicker_index_path(conn, :index))

      assert html =~ "Listing Clickers"
    end

    test "saves new clicker", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.clicker_index_path(conn, :index))

      assert index_live |> element("a", "New Clicker") |> render_click() =~
               "New Clicker"

      assert_patch(index_live, Routes.clicker_index_path(conn, :new))

      assert index_live
             |> form("#clicker-form", clicker: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#clicker-form", clicker: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.clicker_index_path(conn, :index))

      assert html =~ "Clicker created successfully"
    end

    test "updates clicker in listing", %{conn: conn, clicker: clicker} do
      {:ok, index_live, _html} = live(conn, Routes.clicker_index_path(conn, :index))

      assert index_live |> element("#clicker-#{clicker.id} a", "Edit") |> render_click() =~
               "Edit Clicker"

      assert_patch(index_live, Routes.clicker_index_path(conn, :edit, clicker))

      assert index_live
             |> form("#clicker-form", clicker: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#clicker-form", clicker: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.clicker_index_path(conn, :index))

      assert html =~ "Clicker updated successfully"
    end

    test "deletes clicker in listing", %{conn: conn, clicker: clicker} do
      {:ok, index_live, _html} = live(conn, Routes.clicker_index_path(conn, :index))

      assert index_live |> element("#clicker-#{clicker.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#clicker-#{clicker.id}")
    end
  end

  describe "Show" do
    setup [:create_clicker]

    test "displays clicker", %{conn: conn, clicker: clicker} do
      {:ok, _show_live, html} = live(conn, Routes.clicker_show_path(conn, :show, clicker))

      assert html =~ "Show Clicker"
    end

    test "updates clicker within modal", %{conn: conn, clicker: clicker} do
      {:ok, show_live, _html} = live(conn, Routes.clicker_show_path(conn, :show, clicker))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Clicker"

      assert_patch(show_live, Routes.clicker_show_path(conn, :edit, clicker))

      assert show_live
             |> form("#clicker-form", clicker: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#clicker-form", clicker: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.clicker_show_path(conn, :show, clicker))

      assert html =~ "Clicker updated successfully"
    end
  end
end
