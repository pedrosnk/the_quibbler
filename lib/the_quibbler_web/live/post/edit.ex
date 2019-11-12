defmodule TheQuibblerWeb.PostLive.Edit do
  use TheQuibblerWeb, :live

  alias TheQuibbler.Blog
  alias TheQuibblerWeb.PostLive

  def mount(_session, socket) do
    {:ok, assign(socket, content_html: "")}
  end

  def render(assigns) do
    ~L"""
    <h1>Edit Post</h1>
    <%# PostView.render("form.html", assigns) %>
    <%= PostLive.Form.render(assigns) %>

    <span><%= link "Back", to: Routes.live_path(@socket, PostLive.Index) %></span>
    """
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    case Blog.get_post(id) do
      nil ->
        {:noreply, redirect(socket, to: Routes.path(socket, "/404"))}

      post ->
        changeset = Blog.change_post(post)

        {:noreply,
         assign(socket, %{post: post, changeset: changeset, content_html: post.content_html})}
    end
  end

  def handle_event("save", %{"post" => params}, socket) do
    case Blog.update_post(socket.assigns.post, params) do
      {:ok, post} ->
        {:stop,
         socket
         |> put_flash(:info, "Post updated successfully.")
         |> redirect(to: Routes.live_path(socket, PostLive.Index))}
    end
  end
end
