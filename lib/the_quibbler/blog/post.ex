defmodule TheQuibbler.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :content_html, :string
    field :published_at, :naive_datetime
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :content_html, :published_at])
    |> validate_required([:title, :content, :content_html, :published_at])
  end
end
