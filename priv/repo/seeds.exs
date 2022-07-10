# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TemporaryHack.Repo.insert!(%TemporaryHack.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TemporaryHack.{Accounts, AccountsFixtures, PortfolioFixtures}

# Users
_user = AccountsFixtures.user_fixture(%{email: "user@temporaryhack.com", password: "user@temporaryhack.com"})
{:ok, _admin} = %{email: "admin@temporaryhack.com", password: "admin@temporaryhack.com"} |>  AccountsFixtures.user_fixture()
|> Accounts.set_admin()

# Projects
_temporary_hack = PortfolioFixtures.project_fixture(%{github_repo: "temporary_hack"})
