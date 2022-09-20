defmodule TemporaryHack.Hex do
  use Supervisor

  import Cachex.Spec

  alias TemporaryHack.Hex.Client

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
    ] ++ caches()

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp caches do
      [
      Supervisor.child_spec(
        {Cachex,
         [
           name: :hex,
           expiration:
             expiration(
               default: :timer.minutes(4),
               interval: :timer.minutes(2),
               lazy: true
             )
         ]},
        id: :hex
      ),
      ]
  end

  def package(package) do
    Client.package(package)
  end
end
