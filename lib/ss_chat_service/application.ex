defmodule SSChatService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    OpentelemetryPhoenix.setup(adapter: :bandit)
    OpentelemetryEcto.setup([:ss_chat_service, :repo])

    children = [
      SSChatServiceWeb.Telemetry,
      SSChatService.Repo,
      {DNSCluster, query: Application.get_env(:ss_chat_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SSChatService.PubSub},
      # Start a worker by calling: SSChatService.Worker.start_link(arg)
      # {SSChatService.Worker, arg},
      # Start to serve requests, typically the last entry
      SSChatServiceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SSChatService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SSChatServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
