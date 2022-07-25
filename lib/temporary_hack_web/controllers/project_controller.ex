defmodule TemporaryHackWeb.ProjectController do
  use TemporaryHackWeb, :controller

  alias TemporaryHack.Portfolio
  alias TemporaryHack.Portfolio.Project

  alias TemporaryHack.Clients.Github, as: GithubClient
  alias TemporaryHack.Clients.Hex, as: HexClient

  @hex_package_keys ~w(latest_version docs_html_url html_url downloads)
  @github_repo_keys ~w(language description html_url stargazers_count license)

  def index(conn, _params) do
    projects =
      Portfolio.list_projects()
      |> Enum.map(&Map.from_struct/1)
      |> Enum.map(fn project ->
        case github_info(project) do
          {:ok, github_info} ->
            info =
              Map.merge(project, github_info)
              |> enrich()

          other ->
            other
        end
      end)

    render(conn, "index.html", projects: projects)
  end

  defp github_info(project) do
    case GithubClient.repo(project.user, project.repo) do
      {:ok, %{status: 200} = response} -> {:ok, parse_github_response(response.body)}
      {:ok, response} -> {:error, response}
      {:error, reason} -> {:error, reason}
    end
  end

  defp parse_github_response(body) do
    body
    |> Map.take(@github_repo_keys)
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
    |> Map.update!(:license, fn license -> license["spdx_id"] end)
  end

  # Assumes that github repo name === hex.pm package name
  defp enrich(%{language: "Elixir", repo: repo} = info) do
    case hex_info(repo) do
      {:ok, hex_info} -> Map.put_new(info, :hex, hex_info)
      {:error, reason} -> info
    end
  end

  defp enrich(info), do: info

  defp hex_info(package_name) do
    case HexClient.package(package_name) do
      {:ok, %{status: 200} = response} -> {:ok, parse_hex_response(response.body)}
      {:ok, response} -> {:error, response}
      {:error, reason} -> {:error, reason}
    end
  end

  defp parse_hex_response(body) do
    body
    |> Map.take(@hex_package_keys)
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
    |> Map.update!(:downloads, fn v -> v["all"] end)
  end
end
