defmodule TheQuibblerWeb.AdminLive.Index do
  use TheQuibblerWeb, :admin_live_view

  alias TheQuibbler.Blog

  def mount(_params, session, socket) do
    socket =
      socket
      |> assign_current_user(session)
      |> fetch_post_count()

    {:ok, assign_new(socket, :current_user, fn -> session["current_user"] end)}
  end

  def render(assigns) do
    ~L"""
    <div>
      <h1>Welcome <%= @current_user %></h1>
      <div>
        You have <%= @post_count %> posts published
      </div>
    </div>
    """
  end

  defp assign_current_user(socket, session) do
    assign_new(socket, :current_user, fn -> session["current_user"] end)
  end

  defp fetch_post_count(socket) do
    assign(socket, :post_count, Blog.count_posts())
  end
end
