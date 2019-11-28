defmodule TheQuibblerWeb.PostLive.NewTest do
  use TheQuibblerWeb.ConnCase
  import Phoenix.LiveViewTest

  alias TheQuibbler.Blog

  @markdown ~s(
  # H1 example

  1. item 1
  2. item 2

  [I'm a link to example.com](https://example.com\)
  )

  test "renders the markdown version of the input content", %{conn: conn} do
    {:ok, view, html} = live(conn, "/posts/new")

    html = render_change(view, "change_text", %{"post" => %{"content" => @markdown}})
    assert html =~ "<li>item 1"
    assert html =~ "href=\"https://example.com\""
  end
end
