use Mix.Config

# Configure your database
config :banking_app, BankingApp.Repo,
  username: System.get_env("RM_PG_USERNAME") || System.get_env("USER"),
  password: System.get_env("RM_PG_PASSWORD") || "",
  hostname: System.get_env("RM_PG_HOSTNAME") || "localhost",
  database: "banking_app_test",
  pool_size: 1

  config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: System.get_env("ES_PG_USERNAME") || System.get_env("USER"),
  password: System.get_env("ES_PG_PASSWORD") || "",
  hostname: System.get_env("ES_PG_HOSTNAME") || "localhost",
  database: "banking_app_eventstore_test",
  pool_size: 1

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :banking_app, BankingAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :banking_app, consistency: :strong
