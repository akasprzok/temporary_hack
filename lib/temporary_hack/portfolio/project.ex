defmodule TemporaryHack.Portfolio.Project do
  @moduledoc """
  Used to enrich a `TemporaryHack.Portfolio.Project` with metadata
  gathered from a variety of additional APIs.
  """

  require Logger

  alias TemporaryHack.Github
  alias TemporaryHack.Hex

  @hex_package_keys ~w(latest_version docs_html_url html_url downloads)
  @github_repo_keys ~w(language description html_url stargazers_count license)

  @enforce_keys [:title, :url]
  defstruct title: "",
            url: "",
            description: "",
            shields: [],
            tags: []

  def enrich({user, repo}) do
    user
    |> github_info(repo)
    |> case do
      {:ok, gh_info} ->
        project = %__MODULE__{
          title: repo,
          description: gh_info.description,
          url: gh_info.html_url,
          tags: [
            gh_info.language,
            gh_info.license
          ]
        }

        case gh_info.language do
          "Elixir" -> add_hex_info(project)
          _ -> project
        end

      {:error, reason} ->
        Logger.error(
          "Unable to retrieve project #{user} - #{repo} from github: #{inspect(reason)}"
        )

        %__MODULE__{
          title: repo,
          url: "https://github.com/#{user}/#{repo}"
        }
    end
  end

  defp github_info(user, repo) do
    case Github.repo(user, repo) do
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
    case Hex.package(package_name) do
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
