defmodule TemporaryHack.Plug.Logger do
  @moduledoc """
  A plug for logging basic request information in the format:
  To use it, just plug it into the desired module.

      plug TemporaryHack.Plug.Logger, log: :debug

  ## Options

    * `:log` - The log level at which this plug should log its request info.
      Default is `:info`.
      The [list of supported levels](https://hexdocs.pm/logger/Logger.html#module-levels)
      is available in the `Logger` documentation.

  """

  require Logger
  alias Plug.Conn
  @behaviour Plug

  @impl true
  def init(opts) do
    Keyword.get(opts, :log, :info)
  end

  @impl true
  def call(conn, level) do
    Logger.metadata(method: conn.method, path: conn.request_path)
    Logger.log(level, "Starting request")

    start = System.monotonic_time()

    Conn.register_before_send(conn, fn conn ->
      stop = System.monotonic_time()
      diff = System.convert_time_unit(stop - start, :native, :millisecond)
      status = Integer.to_string(conn.status)

      Logger.metadata(
        connection_type: connection_type(conn),
        status: status,
        duration_ms: diff
      )

      Logger.log(level, "Finished request")
      conn
    end)
  end

  defp connection_type(%{state: :set_chunked}), do: "chunked"
  defp connection_type(_), do: "sent"
end
