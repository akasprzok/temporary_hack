defmodule TemporaryHack.Blog.Post do
  @moduledoc """
  A blog post parsed by NimblePublisher.
  """

  @type t :: %__MODULE__{
          id: String.t(),
          title: String.t(),
          body: String.t(),
          date: Date.t(),
          tags: list(String.t()),
          description: String.t()
        }

  @enforce_keys [:id, :title, :body, :date, :tags, :description]
  defstruct [:id, :title, :body, :date, :tags, :description]

  def build(filename, attrs, body) do
    base_name = filename |> Path.basename(".md")
    [year, month, day, id] = base_name |> String.split("-", parts: 4)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")
    struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
  end
end
