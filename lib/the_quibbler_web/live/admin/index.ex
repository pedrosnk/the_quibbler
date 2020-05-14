defmodule TheQuibblerWeb.AdminLive.Index do
  use TheQuibblerWeb, :admin_live_view

  def mount(_params, session, socket) do
    require IEx
    IEx.pry()
    {:ok, assign_new(socket, :current_user, fn -> session["current_user"] end)}
  end

  def render(assigns) do
    ~L"""
    <div >
      <h1>Welcome <%= @current_user %></h1>
    </div>
    """
  end
end
