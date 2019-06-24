defmodule BankingApp.Bank.Events.AccountOpened do
  @derive [Jason.Encoder]

   defstruct [
    :user_uuid,
    :account_uuid,
    :account_code,
    :initial_balance_cents
  ]
end
