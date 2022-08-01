defmodule TemporaryHack.Blog do
  @moduledoc """
  A blog that uses NimblePublisher.

  Blog posts are located in priv/posts.
  """
  alias TemporaryHack.Blog.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:temporary_hack, "priv/posts/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  @spec posts :: list(Post.t())
  def posts, do: @posts
  @spec tags :: list(String.t())
  def tags, do: @tags

  @spec latest(non_neg_integer()) :: list(Post.t())
  def latest(num \\ 3), do: posts() |> Enum.take(num)

  @spec by_id(String.t()) :: Post.t() | nil
  def by_id(id) do
    posts() |> Enum.find(&(&1.id == id))
  end
end
