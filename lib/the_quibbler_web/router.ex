defmodule TheQuibblerWeb.Router do
  use TheQuibblerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TheQuibblerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TheQuibblerWeb.LayoutView, :admin}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TheQuibblerWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/posts", PostLive.Index
    live "/posts/new", PostLive.New
    live "/posts/:id", PostLive.Edit
  end

  scope "/admin", TheQuibblerWeb, as: :admin do
    pipe_through :admin

    live "/", AdminLive.Index, as: :index

    live "/posts", PostLive.Index, :index
    live "/posts/new", PostLive.New, :new
    live "/posts/:id", PostLive.Edit, :edit
  end

  def authenticate(conn, _opts) do
    Plug.Conn.put_session(conn, :current_user, "Pedro")
  end
end
