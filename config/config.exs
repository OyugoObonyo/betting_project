# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :betting_project,
  ecto_repos: [BettingProject.Repo]

# Configures the endpoint
config :betting_project, BettingProjectWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: BettingProjectWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: BettingProject.PubSub,
  live_view: [signing_salt: "aArkgawj"]

# Configure Guardian package
config :betting_project, BettingProjectWeb.Auth.Guardian,
  issuer: "betting_project",
  secret_key: "UZ7VbawhuUxAd6IdvvefGIsiIJ9lOXsJOIaRsDWlikh8Epb6pt0HkNVWDsW9hAhZpr2X"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
