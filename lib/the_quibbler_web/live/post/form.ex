defmodule TheQuibblerWeb.PostLive.Form do
  use TheQuibblerWeb, :live

  def render(assigns) do
    ~L"""
    <%= form_for @changeset, "#", [phx_change: :validate, phx_submit: :save], fn f -> %>
    <%= label f, :title %>
    <%= textarea f, :title %>
    <%= error_tag f, :title %>

    <%= label f, :content %>
    <%= textarea f, :content %>
    <%= error_tag f, :content %>

    <%= label f, :content_html %>
    <%= textarea f, :content_html %>
    <%= error_tag f, :content_html %>

    <%= label f, :published_at %>
    <%= datetime_select f, :published_at %>
    <%= error_tag f, :published_at %>

    <div>
    <%= submit "Save" %>
    </div>
    <% end %>
    """
  end
end
