defmodule EtlWeb.Repo do
  use Ecto.Repo,
    otp_app: :etl_web,
    adapter: Ecto.Adapters.Postgres
end
