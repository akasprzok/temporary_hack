defmodule TemporaryHackWeb.AuthHelper do
  @moduledoc """
  Auth helpers for tests.
  """
  alias TemporaryHack.Users.User

  @user %User{email: "user@user.com", role: "user"}
  @admin %User{email: "admin@admin.com", role: "admin"}

  def sign_in_user(conn) do
    Pow.Plug.assign_current_user(conn, @user, otp_app: :temporary_hack)
  end

  def sign_in_admin(conn) do
    Pow.Plug.assign_current_user(conn, @admin, otp_app: :temporary_hack)
  end
end
