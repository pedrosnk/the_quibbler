defmodule Scroll.Repo.Migrations.AddSlugToPost do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :slug, :text
    end
  end
end
