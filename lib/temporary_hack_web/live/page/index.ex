defmodule TemporaryHackWeb.PageLive.Index do
  @moduledoc false

  use TemporaryHackWeb, :live_view

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    current_user = TemporaryHack.Accounts.get_user_by_session_token(token)
    {:ok, assign(socket, current_user: current_user)}
  end
end
