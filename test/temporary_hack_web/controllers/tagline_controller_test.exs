defmodule TemporaryHackWeb.TaglineControllerTest do
  use TemporaryHackWeb.ConnCase, async: true

  alias TemporaryHack.Frontpage
  alias TemporaryHackWeb.AuthHelper

  @create_attrs %{text: "some text"}
  @update_attrs %{text: "some updated text"}
  @invalid_attrs %{text: nil}

  setup %{conn: conn} do
    authed_conn = AuthHelper.sign_in_admin(conn)
    {:ok, authed_conn: authed_conn}
  end

  def fixture(:tagline) do
    {:ok, tagline} = Frontpage.create_tagline(@create_attrs)
    tagline
  end

  describe "index" do
    test "lists all tag_lines", %{authed_conn: authed_conn} do
      conn = get(authed_conn, Routes.tagline_path(authed_conn, :index))
      assert html_response(conn, 200) =~ "Listing Tag lines"
    end
  end

  describe "new tagline" do
    test "renders form", %{authed_conn: authed_conn} do
      conn = get(authed_conn, Routes.tagline_path(authed_conn, :new))
      assert html_response(conn, 200) =~ "New Tagline"
    end
  end

  describe "create tagline" do
    test "redirects to show when data is valid", %{authed_conn: authed_conn} do
      conn = post(authed_conn, Routes.tagline_path(authed_conn, :create), tagline: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tagline_path(authed_conn, :show, id)

      conn = get(authed_conn, Routes.tagline_path(authed_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tagline"
    end

    test "renders errors when data is invalid", %{authed_conn: authed_conn} do
      conn = post(authed_conn, Routes.tagline_path(authed_conn, :create), tagline: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tagline"
    end
  end

  describe "edit tagline" do
    setup [:create_tagline]

    test "renders form for editing chosen tagline", %{authed_conn: authed_conn, tagline: tagline} do
      conn = get(authed_conn, Routes.tagline_path(authed_conn, :edit, tagline))
      assert html_response(conn, 200) =~ "Edit Tagline"
    end
  end

  describe "update tagline" do
    setup [:create_tagline]

    test "redirects when data is valid", %{authed_conn: authed_conn, tagline: tagline} do
      conn =
        put(authed_conn, Routes.tagline_path(authed_conn, :update, tagline),
          tagline: @update_attrs
        )

      assert redirected_to(conn) == Routes.tagline_path(authed_conn, :show, tagline)

      conn = get(authed_conn, Routes.tagline_path(authed_conn, :show, tagline))
      assert html_response(conn, 200) =~ "some updated text"
    end

    test "renders errors when data is invalid", %{authed_conn: authed_conn, tagline: tagline} do
      conn =
        put(authed_conn, Routes.tagline_path(authed_conn, :update, tagline),
          tagline: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Tagline"
    end
  end

  describe "delete tagline" do
    setup [:create_tagline]

    test "deletes chosen tagline", %{authed_conn: authed_conn, tagline: tagline} do
      conn = delete(authed_conn, Routes.tagline_path(authed_conn, :delete, tagline))
      assert redirected_to(conn) == Routes.tagline_path(authed_conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.tagline_path(authed_conn, :show, tagline))
      end
    end
  end

  defp create_tagline(_) do
    tagline = fixture(:tagline)
    %{tagline: tagline}
  end
end
