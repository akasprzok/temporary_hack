defmodule TemporaryHackWeb.CounterTest do
  use TemporaryHackWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/counter")
    rendered_html = render(page_live)
    assert disconnected_html =~ "Counter"
    assert rendered_html =~ "0"
  end
end
