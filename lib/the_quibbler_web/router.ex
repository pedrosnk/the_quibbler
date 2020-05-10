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

  # Other scopes may use custom stacks.
  # scope "/api", TheQuibblerWeb do
  #   pipe_through :api
  # end
end
