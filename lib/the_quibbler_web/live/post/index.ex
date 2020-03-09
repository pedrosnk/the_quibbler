defmodule TheQuibblerWeb.PostLive.Index do
  use TheQuibblerWeb, :live

  alias TheQuibblerWeb.PostLive
  alias TheQuibbler.Blog

  def mount(_session, socket) do
    {:ok, fetch(socket)}
  end

  def render(assigns) do
    ~L"""
    <h1>Listing Posts</h1>

    <table>
    <thead>
    <tr>
      <th>Title</th>
      <th>Content</th>
      <th>Content html</th>
      <th>Published at</th>

      <th></th>
    </tr>
    </thead>
    <tbody>
    <%= for post <- @posts do %>
    <tr>
      <td><%= post.title %></td>
      <td><%= post.content %></td>
      <td><%= post.content_html %></td>
      <td><%= post.published_at %></td>

      <td>
        <%#= link "Show", to: Routes.post_path(@socket, :show, post) %>
        <%= link "Edit", to: Routes.live_path(@socket, PostLive.Edit, post) %>
        <%= link "Delete", to: "#", "phx-click": "delete", "phx-value-id": post.id %>
      </td>
    </tr>
    <% end %>
    </tbody>
    </table>

    <span><%= link "New Post", to: Routes.live_path(@socket, PostLive.New) %></span>
    """
  end

  defp fetch(socket) do
    assign(socket, posts: Blog.list_posts())
  end

  def handle_event("delete", %{"id" => id}, socket) do
    post = Blog.get_post(id)

    {:ok, _user} = Blog.delete_post(post)
    {:noreply, fetch(socket)}
  end
end
