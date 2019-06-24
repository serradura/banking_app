defmodule BankingApp.Bank.Aggregates.Account do
  defstruct [
    :uuid,
    :code,
    :user_uuid,
    :balance_cents
  ]

  alias BankingApp.Bank.Aggregates.Account
  alias BankingApp.Bank.Commands.OpenAccount
  alias BankingApp.Bank.Events.AccountOpened

  def execute(%Account{uuid: nil, user_uuid: nil}, %OpenAccount{} = cmd) do
    %AccountOpened{
      user_uuid: cmd.user_uuid,
      account_uuid: cmd.account_uuid,
      account_code: cmd.account_code,
      initial_balance_cents: amount_as_cents(1_000)
    }
  end

  # state mutators

  def apply(%Account{} = account, %AccountOpened{} = event) do
    %Account{account |
      uuid: event.account_uuid,
      code: event.account_code,
      user_uuid: event.user_uuid,
      balance_cents: event.initial_balance_cents
    }
  end

  defp amount_as_cents(value) do
    value * 100
  end
end
