defmodule BankingApp.Bank.Projectors.Account do
  use Commanded.Projections.Ecto,
    name: "Bank.Projectors.Account",
    consistency: :strong

  alias BankingApp.Bank.Events.AccountOpened
  alias BankingApp.Bank.Projections.Account

  project %AccountOpened{} = opened, fn multi ->
    Ecto.Multi.insert(multi, :account, %Account{
      uuid: opened.account_uuid,
      code: opened.account_code,
      user_uuid: opened.user_uuid,
      balance_cents: opened.initial_balance_cents
    })
  end
end
