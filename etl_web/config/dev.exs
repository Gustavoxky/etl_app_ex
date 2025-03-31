import Config

# Configure your database
config :etl_web, EtlWeb.Repo,
  username: "postgres",
  password: "postgres",
  # <- AQUI É O PULO DO GATO
  hostname: "db",
  # ou "etl_dev" se for o nome usado no compose
  database: "etl_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Endpoint para desenvolvimento
config :etl_web, EtlWebWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "hkUTC+pytz7kCSNbWLKvCDIfQJikxn+YbvGaXVVt18yzzkH5BCYsm701yPOkFt3O",
  watchers: []

# Outras configs
config :etl_web, dev_routes: true
config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
config :swoosh, :api_client, false
