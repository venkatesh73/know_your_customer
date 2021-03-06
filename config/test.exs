use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :know_your_customer, KYC.Repo,
  username: System.get_env("TEST_DB_USERNAME") || "postgres",
  password: System.get_env("TEST_DB_PASSWORD") || "postgres",
  database: System.get_env("TEST_DB_NAME") || "know_your_customer_test",
  hostname: System.get_env("TEST_DB_HOSTNAME") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :know_your_customer, KYCWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
