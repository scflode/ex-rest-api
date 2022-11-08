defmodule RestApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RestApiWeb.Telemetry,
      # Start the Ecto repository
      RestApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: RestApi.PubSub},
      # Start Finch
      {Finch, name: RestApi.Finch},
      # Start the Endpoint (http/https)
      RestApiWeb.Endpoint
      # Start a worker by calling: RestApi.Worker.start_link(arg)
      # {RestApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RestApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RestApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
