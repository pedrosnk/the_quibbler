defmodule ScrollWeb.PostLive.EditTest do
  use ScrollWeb.ConnCase
  import Phoenix.LiveViewTest

  alias Scroll.Blog

  @markdown """
  # H1 example
  """

  @markdown_html """
  <h1>H1 example</h1>
  """

  @valid_attrs %{
    slug: "some-title",
    content: @markdown,
    content_html: @markdown_html,
    published_at: ~N[2010-04-17 14:00:00],
    title: "some title"
  }

  test "renders the markdown on page load", %{conn: conn} do
    {:ok, post} = Blog.create_post(@valid_attrs)
    {:ok, _view, html} = live(conn, "admin/posts/#{post.id}")

    assert html =~ "<h1>H1 example</h1>"
  end

  test "renders the markdown on page changeg", %{conn: conn} do
    {:ok, post} = Blog.create_post(@valid_attrs)
    {:ok, view, _html} = live(conn, "admin/posts/#{post.id}")

    input_markdown = "## This is an h2"

    html = render_change(view, "change_text", %{"post" => %{"content" => input_markdown}})

    assert html =~ "<h2>\nThis is an h2</h2>"
  end
end
