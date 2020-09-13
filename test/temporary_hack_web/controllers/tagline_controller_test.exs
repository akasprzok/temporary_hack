defmodule TemporaryHackWeb.TaglineControllerTest do
  use TemporaryHackWeb.ConnCase

  alias TemporaryHack.Frontpage

  @create_attrs %{text: "some text"}
  @update_attrs %{text: "some updated text"}
  @invalid_attrs %{text: nil}

  def fixture(:tagline) do
    {:ok, tagline} = Frontpage.create_tagline(@create_attrs)
    tagline
  end

  describe "index" do
    test "lists all tag_lines", %{conn: conn} do
      conn = get(conn, Routes.tagline_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tag lines"
    end
  end

  describe "new tagline" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tagline_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tagline"
    end
  end

  describe "create tagline" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tagline_path(conn, :create), tagline: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tagline_path(conn, :show, id)

      conn = get(conn, Routes.tagline_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tagline"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tagline_path(conn, :create), tagline: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tagline"
    end
  end

  describe "edit tagline" do
    setup [:create_tagline]

    test "renders form for editing chosen tagline", %{conn: conn, tagline: tagline} do
      conn = get(conn, Routes.tagline_path(conn, :edit, tagline))
      assert html_response(conn, 200) =~ "Edit Tagline"
    end
  end

  describe "update tagline" do
    setup [:create_tagline]

    test "redirects when data is valid", %{conn: conn, tagline: tagline} do
      conn = put(conn, Routes.tagline_path(conn, :update, tagline), tagline: @update_attrs)
      assert redirected_to(conn) == Routes.tagline_path(conn, :show, tagline)

      conn = get(conn, Routes.tagline_path(conn, :show, tagline))
      assert html_response(conn, 200) =~ "some updated text"
    end

    test "renders errors when data is invalid", %{conn: conn, tagline: tagline} do
      conn = put(conn, Routes.tagline_path(conn, :update, tagline), tagline: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tagline"
    end
  end

  describe "delete tagline" do
    setup [:create_tagline]

    test "deletes chosen tagline", %{conn: conn, tagline: tagline} do
      conn = delete(conn, Routes.tagline_path(conn, :delete, tagline))
      assert redirected_to(conn) == Routes.tagline_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.tagline_path(conn, :show, tagline))
      end
    end
  end

  defp create_tagline(_) do
    tagline = fixture(:tagline)
    %{tagline: tagline}
  end
end
