defmodule ScrollWeb.PostLive.IndexTest do
  use ScrollWeb.ConnCase
  import Phoenix.LiveViewTest

  alias Scroll.Blog

  test "renders post list messageg", %{conn: conn} do
    Blog.create_post(%{title: "Post 1", slug: "hello-post-1", content: "Hello Post 1", content_html: "Hello Post 1"})
    Blog.create_post(%{title: "Post 2", slug: "hello-post-2", content: "Hello Post 2", content_html: "Hello Post 2"})
    {:ok, view, html} = live(conn, "admin/posts")
    assert html =~ "Post 1"
    assert html =~ "Post 2"
  end
end
