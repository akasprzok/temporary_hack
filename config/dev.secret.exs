use Mix.Config

github_client_id =
  System.get_env("GITHUB_CLIENT_ID") ||
    raise """
    environment variable GITHUB_CLIENT_ID is missing.
    """

github_secret_id =
  System.get_env("GITHUB_CLIENT_SECRET") ||
    raise """
    environment variable GITHUB_CLIENT_SECRET is missing.
    """

config :temporary_hack, :pow_assent,
  providers: [
    github: [
      client_id: github_client_id,
      client_secret: github_secret_id,
      strategy: Assent.Strategy.Github
    ]
  ]
