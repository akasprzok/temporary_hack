defmodule TemporaryHack.Hex.ErlangMiddleware do
  @moduledoc """
  Middleware for decoding erlang responses from REST APIs.
  """
  @behaviour Tesla.Middleware

  @impl Tesla.Middleware
  def call(env, next, _options) do
    env
    |> Tesla.run(next)
    |> decode_body()
  end

  defp decode_body({:ok, env}) do
    {:ok, Map.update!(env, :body, &:erlang.binary_to_term/1)}
  end
end
