defmodule TheQuibblerWeb.PostLive.New do
  use Phoenix.LiveView

  alias TheQuibblerWeb.Router.Helpers, as: Routes
  alias TheQuibblerWeb.PostLive
  alias TheQuibblerWeb.PostView
  alias TheQuibbler.Blog.Post
  alias TheQuibbler.Blog

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: Blog.change_post(%Post{}))}
  end

  def render(assigns), do: PostView.render("new.html", assigns)

  def handle_event("validate", %{"post" => params}, socket) do
    changeset =
      %Post{}
      |> Blog.change_post(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
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
