defmodule TemporaryHackWeb.PageControllerTest do
  use TemporaryHackWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Hi, I'm Andreas Kasprzok"
  end
end
