# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :banking_app,
  ecto_repos: [BankingApp.Repo]

# Configures the endpoint
config :banking_app, BankingAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "msWGEjQw0AZNQGYZLMKr1SF3DP6Z1Y4QnuQTfoboKtO+NeXehaczVzGHOh37l4ai",
  render_errors: [view: BankingAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BankingApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :comeonin, :bcrypt_log_rounds, 4

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: BankingApp.Repo

config :vex,
  sources: [
    BankingApp.Support.Validators,
     Vex.Validators
  ]

config :banking_app, BankingAppWeb.Auth.Guardian,
  issuer: "banking_app",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "cIT0dJ8/UMB8C8P8LoUrLY9sI8eEs8pACxv9byj58ZcN0oxGHACDG3t9G2+uOXHJ"

config :money,
  default_currency: :BRL,
  separator: ".",
  delimeter: ",",
  symbol_space: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
