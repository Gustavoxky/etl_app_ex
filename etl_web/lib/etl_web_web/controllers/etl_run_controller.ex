defmodule EtlWebWeb.EtlRunController do
  use EtlWebWeb, :controller

  alias EtlWeb.Repo
  alias EtlWeb.Data.EtlRun

  def index(conn, _params) do
    runs = Repo.all(EtlRun)
    json(conn, runs)
  end
end
