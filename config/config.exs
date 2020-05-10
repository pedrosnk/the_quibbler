# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :the_quibbler,
  ecto_repos: [TheQuibbler.Repo]

# Configures the endpoint
config :the_quibbler, TheQuibblerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9wMprGeqVPWKMmwpNTuK9eqoUiUAGDrOjXlELg9Ji+ecJa4HYuVRpav+TTdIQHbp",
  render_errors: [view: TheQuibblerWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: TheQuibbler.PubSub,
  live_view: [
    signing_salt: "dz9mi6F7RfjA7pGhV9IRHngRqsA5ioVgL5Tr1yCaI+g0TebTFKeo56dgDD1pxZKn"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
