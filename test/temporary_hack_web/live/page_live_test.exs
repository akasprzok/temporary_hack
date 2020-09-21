defmodule TemporaryHackWeb.PageLiveTest do
  use TemporaryHackWeb.ConnCase

  alias TemporaryHack.Frontpage
  alias TemporaryHack.Blog

  import Phoenix.LiveViewTest

  @tagline "I am a tagline"
  @post_title "post title"
  @post_body "post body"

  setup do
    {:ok, _} = Frontpage.create_tagline(%{text: @tagline})
    {:ok, _} = Blog.create_post(%{
      title: @post_title,
      body: @post_body
    })
    :ok
  end

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    rendered_html = render(page_live)
    assert disconnected_html =~ "Welcome to Temporary Hack!"
    assert rendered_html =~ @tagline
    assert rendered_html =~ @post_title
    assert rendered_html =~ @post_body
  end

end
