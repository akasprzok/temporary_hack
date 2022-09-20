defmodule TemporaryHack.Github do
  use Supervisor

  import Cachex.Spec

  alias TemporaryHack.Github.Client

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
           name: :github_repo,
           expiration:
             expiration(
               default: :timer.minutes(4),
               interval: :timer.minutes(2),
               lazy: true
             )
         ]},
        id: :github_repo
      ),
      Supervisor.child_spec(
        {Cachex,
         [
           name: :github_latest_commit,
           expiration:
             expiration(
               default: :timer.minutes(4),
               interval: :timer.minutes(2),
               lazy: true
             )
         ]},
        id: :github_latest_commit
      )
      ]
  end

  def repo(owner, repo) do
    Client.repo(owner, repo)
  end
end
