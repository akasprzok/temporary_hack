defmodule TemporaryHackWeb.TaglineController do
  use TemporaryHackWeb, :controller

  alias TemporaryHack.Frontpage
  alias TemporaryHack.Frontpage.Tagline

  def index(conn, _params) do
    tag_lines = Frontpage.list_tag_lines()
    render(conn, "index.html", tag_lines: tag_lines)
  end

  def new(conn, _params) do
    changeset = Frontpage.change_tagline(%Tagline{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tagline" => tagline_params}) do
    case Frontpage.create_tagline(tagline_params) do
      {:ok, tagline} ->
        conn
        |> put_flash(:info, "Tagline created successfully.")
        |> redirect(to: Routes.tagline_path(conn, :show, tagline))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tagline = Frontpage.get_tagline!(id)
    render(conn, "show.html", tagline: tagline)
  end

  def edit(conn, %{"id" => id}) do
    tagline = Frontpage.get_tagline!(id)
    changeset = Frontpage.change_tagline(tagline)
    render(conn, "edit.html", tagline: tagline, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tagline" => tagline_params}) do
    tagline = Frontpage.get_tagline!(id)

    case Frontpage.update_tagline(tagline, tagline_params) do
      {:ok, tagline} ->
        conn
        |> put_flash(:info, "Tagline updated successfully.")
        |> redirect(to: Routes.tagline_path(conn, :show, tagline))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tagline: tagline, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tagline = Frontpage.get_tagline!(id)
    {:ok, _tagline} = Frontpage.delete_tagline(tagline)

    conn
    |> put_flash(:info, "Tagline deleted successfully.")
    |> redirect(to: Routes.tagline_path(conn, :index))
  end
end
