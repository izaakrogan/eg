# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eg,
  ecto_repos: [Eg.Repo]

# Configures the endpoint
config :eg, EgWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t6DCP8G74/xbqo3GH+FCZhAtGYxkkCdoIstGysj2LBBa2COMeEAceDu1zi/KEN10",
  render_errors: [view: EgWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Eg.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "9babcecd9c88db7df89f",
  client_secret: "bd7057d020f1f9469aa1d4b5007eece7d1e3a898"
