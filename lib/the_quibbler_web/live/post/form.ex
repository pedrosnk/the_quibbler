defmodule TheQuibblerWeb.PostLive.Form do
  use Phoenix.LiveComponent
  use TheQuibblerWeb, :live

  def render(assigns) do
    ~L"""
    <%= form_for @changeset, "#", [phx_submit: :save, "phx-change": "change_text" ], fn f -> %>
    <div class="row">
      <%= text_input f, :title, placeholder: "Title"%>
    </div>
    <div class="row">
      <%= error_tag f, :title %>
    </div>

    <div class="row">
      <div class="column column-50">
        <div class="row">
          <%= label f, :content %>
        </div>
        <div class="row">
          <%= textarea f, :content %>
        </div>
        <%= error_tag f, :content %>

      </div>

      <div class="column column-50">
        <%= label f, :content_html %>
        <%= textarea f, :content_html, hidden: true %>
        <div>
          <%= raw @content_html %>
        </div>
        <%= error_tag f, :content_html %>
      </div>
    </div>
    <div>
    <%= submit "Save" %>
    </div>
    <% end %>
    """
  end
end
