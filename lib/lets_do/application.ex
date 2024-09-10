defmodule LetsDo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LetsDoWeb.Telemetry,
      LetsDo.Repo,
      {DNSCluster, query: Application.get_env(:lets_do, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LetsDo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LetsDo.Finch},
      # Start a worker by calling: LetsDo.Worker.start_link(arg)
      # {LetsDo.Worker, arg},
      # Start to serve requests, typically the last entry
      LetsDoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LetsDo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LetsDoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
