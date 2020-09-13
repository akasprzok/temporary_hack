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
alias TemporaryHack.Users

Users.create_admin!(%{
  email: "admin@admin.com",
  password: "adminadmin",
  password_confirmation: "adminadmin"
})

alias TemporaryHack.Frontpage
[
  "Click Me!",
  "Now with less Java!",
  "Functional Programming is neat!"
]
|> Enum.map(&%{text: &1})
|> Enum.each(&Frontpage.create_tagline!/1)
