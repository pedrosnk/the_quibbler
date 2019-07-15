defmodule TheQuibbler.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :text
      add :content, :text
      add :content_html, :text
      add :published_at, :naive_datetime

      timestamps()
    end

  end
end
