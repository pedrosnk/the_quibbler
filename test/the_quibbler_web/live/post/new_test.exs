defmodule ScrollWeb.PostLive.NewTest do
  use ScrollWeb.ConnCase
  import Phoenix.LiveViewTest

  alias Scroll.Blog

  @markdown ~s(
  # H1 example

  1. item 1
  2. item 2

  [I'm a link to example.com](https://example.com\)
  )

  test "renders the markdown version of the input content", %{conn: conn} do
    {:ok, view, html} = live(conn, "admin/posts/new")

    html = render_change(view, "change_text", %{"post" => %{"content" => @markdown}})
    assert html =~ "<li>\nitem 1"
    assert html =~ "href=\"https://example.com\""
  end
end
