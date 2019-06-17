use Mix.Config

# Configure your database
config :banking_app, BankingApp.Repo,
  database: "banking_app_test",
  hostname: "localhost",
  pool_size: 1

  config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  database: "banking_app_eventstore_test",
  hostname: "localhost",
  pool_size: 1

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :banking_app, BankingAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
