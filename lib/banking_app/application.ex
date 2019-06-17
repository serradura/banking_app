defmodule BankingApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      supervisor(BankingApp.Repo, []),
      # Start the endpoint when the application starts
      supervisor(BankingAppWeb.Endpoint, []),
      # Starts a worker by calling: BankingApp.Worker.start_link(arg)
      # {BankingApp.Worker, arg},
      # Start the Accounts supervisor
      supervisor(BankingApp.Accounts.Supervisor, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BankingApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BankingAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
