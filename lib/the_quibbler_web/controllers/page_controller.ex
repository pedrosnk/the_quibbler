defmodule TheQuibblerWeb.PageController do
  use TheQuibblerWeb, :controller
  alias TheQuibbler.Blog

  def index(conn, _params) do
    posts = render(conn, "index.html", posts: Blog.list_posts())
  end
end
