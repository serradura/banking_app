defmodule BankingApp.Bank.Supervisor do
  use Supervisor

  alias BankingApp.Bank

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Bank.Projectors.Account
    ], strategy: :one_for_one)
  end
end
