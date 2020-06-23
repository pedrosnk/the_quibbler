defmodule Scroll.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :text
      add :content, :text
      add :content_html, :text
      add :published_at, :naive_datetime

      timestamps()
    end
  end
end
