defmodule TemporaryHack.Portfolio.ProjectWithMetadata do
  @moduledoc """
  Used to enrich a `TemporaryHack.Portfolio.Project` with metadata
  gathered from a variety of additional APIs.
  """

  require Logger

  alias TemporaryHack.Clients.Github, as: GithubClient
  alias TemporaryHack.Clients.Hex, as: HexClient

  @hex_package_keys ~w(latest_version docs_html_url html_url downloads)
  @github_repo_keys ~w(language description html_url stargazers_count license)

  @enforce_keys [:title, :url]
  defstruct title: "",
            url: "",
            description: "",
            shields: [],
            tags: []

  def enrich(project) do
    project
    |> github_info()
    |> case do
      {:ok, gh_info} ->
        project_with_metadata = %__MODULE__{
          title: project.repo,
          description: gh_info.description,
          url: gh_info.html_url,
          tags: [
            gh_info.language,
            gh_info.license
          ]
        }

        case gh_info.language do
          "Elixir" -> add_hex_info(project_with_metadata)
          _ -> project_with_metadata
        end

      {:error, reason} ->
        Logger.error(
          "Unable to retrieve project #{project.user} - #{project.repo} from github: #{inspect(reason)}"
        )

        %__MODULE__{
          title: project.repo,
          url: "https://github.com/#{project.user}/#{project.repo}"
        }
    end
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

  defp add_hex_info(project_with_metadata) do
    case hex_info(project_with_metadata.title) do
      {:ok, info} ->
        %{
          project_with_metadata
          | shields:
              [
                {"https://img.shields.io/hexpm/v/#{project_with_metadata.title}.svg",
                 info.html_url},
                {"https://img.shields.io/badge/hex-docs-informational.svg", info.docs_html_url}
              ] ++ project_with_metadata.shields
        }

      {:error, _} ->
        project_with_metadata
    end
  end

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
