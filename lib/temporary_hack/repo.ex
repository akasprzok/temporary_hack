defmodule TemporaryHack.Repo do
  use Ecto.Repo,
    otp_app: :temporary_hack,
    adapter: Ecto.Adapters.Postgres
end
