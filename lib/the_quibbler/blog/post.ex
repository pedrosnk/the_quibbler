defmodule TheQuibbler.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :content, :string
    field :content_html, :string
    field :published_at, :naive_datetime
    field :title, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :content_html, :slug, :published_at])
    |> validate_required([:title, :content, :slug, :content_html])
    |> validate_format(:slug, ~r/^[\w\-]+$/, message: "Format is invalid")
    |> change_slug()
  end

  def change_slug(%{changes: %{title: title}, data: %{slug: nil}} = post) do
    slug =
      for c <- String.graphemes(title), into: "" do
        case c do
          " " -> "-"
          "#" -> "-"
          "?" -> "-"
          "/" -> "-"
          c -> c |> String.downcase() |> URI.encode()
        end
      end

    cast(post, %{"slug" => slug}, [:slug])
  end

  def change_slug(changeset), do: changeset
end
