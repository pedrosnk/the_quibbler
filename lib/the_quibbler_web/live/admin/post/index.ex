defmodule TheQuibblerWeb.Admin.PostLive.Index do
  use TheQuibblerWeb, :admin_live_view

  alias TheQuibblerWeb.Admin.PostLive
  alias TheQuibbler.Blog

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [posts: fetch()]}
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
        <%= live_redirect "Edit", to: Routes.admin_post_edit_path(@socket, :edit, post) %>
        <%= link "Delete", to: "#", "phx-click": "delete", "phx-value-id": post.id %>
      </td>
    </tr>
    <% end %>
    </tbody>
    </table>

    <span><%= live_redirect "New Post", to: Routes.admin_post_index_path(@socket, :index) %></span>
    """
  end

  defp fetch() do
    Blog.list_posts()
  end

  def handle_event("delete", %{"id" => id}, socket) do
    post = Blog.get_post(id)

    {:ok, _user} = Blog.delete_post(post)

    {:noreply,
     socket
     |> put_flash(:info, "Post deleted")
     |> assign(:posts, fetch())}
  end
end
