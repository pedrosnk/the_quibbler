defmodule ScrollWeb.PageController do
  use ScrollWeb, :controller
  alias Scroll.Blog

  def index(conn, _params) do
    posts = render(conn, "index.html", posts: Blog.list_posts())
  end
end
