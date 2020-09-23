# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :know_your_customer,
  namespace: KYC,
  ecto_repos: [KYC.Repo]

# Configures the endpoint
config :know_your_customer, KYCWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oTj9MbELEHW0WkPlveH5trnKJcQalRQZB/uhNgYzIU+4CjpggULohuKD2ckHCq+F",
  render_errors: [view: KYCWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: KYC.PubSub,
  live_view: [signing_salt: "XxZiF2Sk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
