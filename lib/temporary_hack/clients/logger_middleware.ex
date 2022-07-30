defmodule TemporaryHack.Middleware.Logger do
  @moduledoc ~S"""
  A heavily simplified Tesla Logger middleware that
  uses Logger.metadata.

  ## Options
  - `:log_level` - custom function for calculating log level
  """

  @behaviour Tesla.Middleware

  require Logger

  @impl Tesla.Middleware
  def call(env, next, opts) do
    {time, response} = :timer.tc(Tesla, :run, [env, next])

    level = log_level(response, opts)
    method = env.method |> to_string() |> String.upcase()

    status =
      response
      |> case do
        {:ok, env} -> to_string(env.status)
        {:error, reason} -> "error: " <> inspect(reason)
      end

    duration_ms = :io_lib.format("~.3f", [time / 1000])
    query = env.query |> Tesla.encode_query()

    Logger.log(level, "Finished request",
      method: method,
      url: env.url,
      status: status,
      duration_ms: duration_ms,
      query: query
    )

    response
  end

  defp log_level({:error, _}, _), do: :error

  defp log_level({:ok, env}, config) do
    case Keyword.get(config, :log_level) do
      nil ->
        default_log_level(env)

      fun when is_function(fun) ->
        case fun.(env) do
          :default -> default_log_level(env)
          level -> level
        end

      atom when is_atom(atom) ->
        atom
    end
  end

  @spec default_log_level(Tesla.Env.t()) :: atom()
  def default_log_level(env) do
    cond do
      env.status >= 400 -> :error
      env.status >= 300 -> :warn
      true -> :info
    end
  end
end
