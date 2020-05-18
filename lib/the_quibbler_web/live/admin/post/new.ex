defmodule TheQuibblerWeb.Admin.PostLive.New do
  use TheQuibblerWeb, :admin_live_view

  alias TheQuibblerWeb.Admin.PostLive
  alias TheQuibblerWeb.PostView
  alias TheQuibbler.Blog.Post
  alias TheQuibbler.Blog

  def mount(_params, _session, socket) do
    {:ok, assign(socket, changeset: Blog.change_post(%Post{}), content_html: "")}
  end

  def render(assigns) do
    ~L"""
    <h1>New Post</h1>
    <%= PostLive.Form.render(assigns) %>
    <span><%= live_redirect "Back", to: Routes.admin_post_index_path(@socket, :index) %></span>
    """
  end

  def handle_event("save", %{"post" => params}, socket) do
    case Blog.create_post(params) do
      {:ok, post} ->
        socket =
          socket
          |> put_flash(:info, "Post created")
          |> push_redirect(to: Routes.admin_post_index_path(socket, :index))

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event(
        "change_text",
        %{"post" => post},
        %{assigns: %{changeset: changeset}} = socket
      ) do
    {_status, content_html, _errors} = Earmark.as_html(post["content"])
    changeset = Blog.change_post(changeset.data, put_in(post, ["content_html"], content_html))

    {:noreply, assign(socket, changeset: changeset, content_html: content_html)}
  end
end
