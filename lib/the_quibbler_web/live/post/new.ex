defmodule TheQuibblerWeb.PostLive.New do
  use TheQuibblerWeb, :live

  alias TheQuibblerWeb.PostLive
  alias TheQuibblerWeb.PostView
  alias TheQuibbler.Blog.Post
  alias TheQuibbler.Blog

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: Blog.change_post(%Post{}), content_html: "")}
  end

  def render(assigns) do
    ~L"""
    <h1>New Post</h1>
    <%= PostLive.Form.render(assigns) %>
    <span><%= link "Back", to: Routes.live_path(@socket, PostLive.Index) %></span>
    """
  end

  def handle_event("save", %{"post" => params}, socket) do
    case Blog.create_post(params) do
      {:ok, post} ->
        socket =
          socket
          |> put_flash(:info, "Post created")
          |> redirect(to: Routes.live_path(socket, PostLive.Index))

        {:stop, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event(
        "change_text",
        %{"post" => %{"content" => content}},
        %{assigns: %{changeset: changeset}} = socket
      ) do
    {_status, content_html, _errors} = Earmark.as_html(content)

    changeset =
      Blog.change_post(changeset.data, %{"content" => content, "content_html" => content_html})

    {:noreply, assign(socket, changeset: changeset, content_html: content_html)}
  end
end
