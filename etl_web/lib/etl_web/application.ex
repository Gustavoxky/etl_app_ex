defmodule EtlWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EtlWebWeb.Telemetry,
      EtlWeb.Repo,
      {DNSCluster, query: Application.get_env(:etl_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EtlWeb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EtlWeb.Finch},
      # Start a worker by calling: EtlWeb.Worker.start_link(arg)
      # {EtlWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      EtlWebWeb.Endpoint,
      EtlWeb.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EtlWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EtlWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
