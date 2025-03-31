# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :etl_web,
  ecto_repos: [EtlWeb.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :etl_web, EtlWeb.Scheduler,
  jobs: [
    # executa a cada 5 minutos
    {"*/5 * * * *", {EtlApp.ETL.Importer, :run, []}}
  ]

# Configures the endpoint
config :etl_web, EtlWebWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: EtlWebWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: EtlWeb.PubSub,
  live_view: [signing_salt: "a3E7FcwI"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :etl_web, EtlWeb.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
