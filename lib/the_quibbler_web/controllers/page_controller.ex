defmodule TheQuibblerWeb.PageController do
  use TheQuibblerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
