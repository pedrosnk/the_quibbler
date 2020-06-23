defmodule ScrollWeb.Admin.PostLive.New do
  use ScrollWeb, :admin_live_view

  alias ScrollWeb.Admin.PostLive
  alias ScrollWeb.PostView
  alias Scroll.Blog.Post
  alias Scroll.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, changeset: Blog.change_post(%Post{}), content_html: "")}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>New Post</h1>
    <%= live_component @socket, PostLive.Form, content_html: @content_html, changeset: @changeset %>
    <span><%= live_redirect "Back", to: Routes.admin_post_index_path(@socket, :index) %></span>
    """
  end

  @impl true
  def handle_event("save", %{"post" => params}, socket) do
    case Blog.create_post(params) do
      {:ok, _post} ->
        socket =
          socket
          |> put_flash(:info, "Post created")
          |> push_redirect(to: Routes.admin_post_index_path(socket, :index))

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
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
