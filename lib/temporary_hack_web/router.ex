defmodule TemporaryHackWeb.Router do
  use TemporaryHackWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TemporaryHackWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler

    plug TemporaryHackWeb.EnsureRolePlug, :admin
  end

  scope "/" do
    pipe_through :skip_csrf_protection
    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_assent_routes()
  end

  scope "/", TemporaryHackWeb do
    pipe_through [:browser, :admin]

    live_dashboard "/dashboard", metrics: TemporaryHackWeb.Telemetry
    resources "/tag_lines", TaglineController
  end

  scope "/", TemporaryHackWeb do
    pipe_through :browser

    live "/", PageLive, :index
    resources "/posts", PostController
    live "/counter", Counter
  end
end
