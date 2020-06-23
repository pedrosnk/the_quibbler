defmodule ScrollWeb.Admin.PostLive.Edit do
  use ScrollWeb, :admin_live_view

  alias Scroll.Blog
  alias ScrollWeb.Admin.PostLive

  def mount(_session, socket) do
    {:ok, assign(socket, content_html: "")}
  end

  def render(assigns) do
    ~L"""
    <h1>Edit Post</h1>
    <%# PostView.render("form.html", assigns) %>
    <%= live_component @socket, PostLive.Form, content_html: @content_html, changeset: @changeset %>

    <span><%= live_redirect "Back", to: Routes.admin_post_index_path(@socket, :index) %></span>
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
      {:ok, _post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post updated successfully.")
         |> push_redirect(to: Routes.admin_post_index_path(socket, :index))}
    end
  end

  def handle_event("publish", _value, socket) do
    %{assigns: %{post: post}} = socket
    post = Blog.publish(post)

    put_flash(socket, :info, "Post published")
  end

  def handle_event(
        "change_text",
        %{"post" => post},
        %{assigns: %{changeset: changeset}} = socket
      ) do
    {_status, content_html, _errors} = Earmark.as_html(post["content"])

    post =
      post
      |> put_in(["content_html"], content_html)
      |> put_in(["title"], post["title"])

    changeset = Blog.change_post(changeset.data, post)

    {:noreply, assign(socket, changeset: changeset, content_html: content_html)}
  end
end
