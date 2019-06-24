defmodule BankingApp.Bank.Workflows.CreateAccountFromUser do
  use Commanded.Event.Handler,
    name: "Bank.Workflows.CreateAccountFromUser",
    consistency: :strong

  alias BankingApp.Accounts.Events.UserRegistered
  alias BankingApp.Bank

  def handle(%UserRegistered{user_uuid: user_uuid}, _metadata) do
    case Bank.open_account(%{user_uuid: user_uuid}) do
      {:ok, _} -> :ok
      reply    -> reply
    end
  end
end
