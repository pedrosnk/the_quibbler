defmodule TheQuibblerWeb.PostLive.New do
  use TheQuibblerWeb, :live

  alias TheQuibblerWeb.PostLive
  alias TheQuibblerWeb.PostView
  alias TheQuibbler.Blog.Post
  alias TheQuibbler.Blog

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: Blog.change_post(%Post{}))}
  end

  def render(assigns) do
    ~L"""
    <h1>New Post</h1>
    <%# PostView.render("form.html", assigns) %>
    <%= PostLive.Form.render(assigns) %>

    <span><%= link "Back", to: Routes.live_path(@socket, PostLive.Index) %></span>
    """
  end

  def handle_event("save", %{"post" => params}, socket) do
    case Blog.create_post(params) do
      {:ok, post} ->
        socket =
          socket
          # chaneg to show
          |> put_flash(:info, "Post created")
          |> redirect(to: Routes.live_path(socket, PostLive.Index))

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
