defmodule TemporaryHack.PipelineInstrumenter do
  @moduledoc false
  use Prometheus.PlugPipelineInstrumenter

  @spec label_value(:request_path, Plug.Conn.t()) :: String.t()
  def label_value(:request_path, conn) do
    conn.request_path()
  end
end
