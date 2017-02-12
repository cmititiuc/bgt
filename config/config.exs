# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bgt,
  ecto_repos: [Bgt.Repo]

# Configures the endpoint
config :bgt, Bgt.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uTUhsPQTvhLUF8G2KkMh6Ge1paEIZCXSAP8YEBntFL5Wc5KRDTZZd3SXVUw8LtMl",
  render_errors: [view: Bgt.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bgt.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
