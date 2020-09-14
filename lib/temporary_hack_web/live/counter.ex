defmodule TemporaryHackWeb.Counter do
  use Phoenix.LiveView

  @topic "live"

  def mount(_params, _session, socket) do
    TemporaryHackWeb.Endpoint.subscribe(@topic)
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("inc", _, socket) do
    updated_state = update(socket, :count, &(&1 + 1))
    TemporaryHackWeb.Endpoint.broadcast_from(self(), @topic, "inc", updated_state.assigns)
    {:noreply, updated_state}
  end

  def handle_event("dec", _, socket) do
    updated_state = update(socket, :count, &(&1 - 1))
    TemporaryHackWeb.Endpoint.broadcast_from(self(), @topic, "dec", updated_state.assigns)
    {:noreply, updated_state}
  end

  def handle_info(msg, socket) do
    {:noreply, assign(socket, count: msg.payload.count)}
  end
end
