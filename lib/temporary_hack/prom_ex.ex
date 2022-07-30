defmodule TemporaryHack.PromEx do
  @moduledoc false

  use PromEx, otp_app: :temporary_hack

  alias PromEx.Plugins

  @impl true
  def plugins do
    [
      # PromEx built in plugins
      Plugins.Application,
      Plugins.Beam,
      {Plugins.Phoenix, router: TemporaryHackWeb.Router, endpoint: TemporaryHackWeb.Endpoint},
      Plugins.Ecto,
      # Plugins.Oban,
      Plugins.PhoenixLiveView,
      # Plugins.Absinthe,
      # Plugins.Broadway,

      # Add your own PromEx metrics plugins
      # TemporaryHack.Users.PromExPlugin
    ]
  end

  @impl true
  def dashboard_assigns do
    [
      datasource_id: "temporary_hack_prometheus",
      default_selected_interval: "30s"
    ]
  end

  @impl true
  def dashboards do
    [
      # PromEx built in Grafana dashboards
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "phoenix.json"},
      {:prom_ex, "ecto.json"},
      # {:prom_ex, "oban.json"},
      {:prom_ex, "phoenix_live_view.json"},
      # {:prom_ex, "absinthe.json"},
      # {:prom_ex, "broadway.json"},

      # Add your dashboard definitions here with the format: {:otp_app, "path_in_priv"}
      # {:temporary_hack, "/grafana_dashboards/user_metrics.json"}
    ]
  end
end
