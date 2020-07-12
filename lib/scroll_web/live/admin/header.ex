defmodule ScrollWeb.AdminLive.Header do
  use ScrollWeb, :admin_live_view

  def mount(_params, %{"current_user" => current_user} = _session, socket) do
    {:ok, assign(socket, :current_user, current_user)}
  end

  def render(assigns) do
    ~L"""
    <header>
    <nav>
      <ul class='float-left'>
        <li><%= live_patch "Home", to: Routes.page_path(@socket, :index) %></li>
        <li><%= live_patch "Posts", to: Routes.admin_post_index_path(@socket, :index) %></li>
      </ul>

      <ul class='float-right'>
        <li><%= link "Logout (#{@current_user})", to: "#" %></li>
      </ul>
    </nav>
    </header>
    """
  end
end
