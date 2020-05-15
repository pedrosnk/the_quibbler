defmodule TheQuibbler.BlogTest do
  use TheQuibbler.DataCase

  alias TheQuibbler.Blog

  describe "posts" do
    alias TheQuibbler.Blog.Post

    @valid_attrs %{
      content: "some content",
      content_html: "some content_html",
      published_at: ~N[2010-04-17 14:00:00],
      title: "some title"
    }
    @update_attrs %{
      content: "some updated content",
      content_html: "some updated content_html",
      published_at: ~N[2011-05-18 15:01:01],
      title: "some updated title"
    }
    @invalid_attrs %{content: nil, content_html: nil, published_at: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "count_posts/0 returns the posts counts" do
      assert {:ok, %Post{}} = Blog.create_post(@valid_attrs)
      assert {:ok, %Post{}} = Blog.create_post(@valid_attrs)
      assert 2 = Blog.count_posts()
    end

    test "get_post/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.content_html == "some content_html"
      assert post.published_at == ~N[2010-04-17 14:00:00]
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.content_html == "some updated content_html"
      assert post.published_at == ~N[2011-05-18 15:01:01]
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert Blog.get_post(post.id) == nil
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
