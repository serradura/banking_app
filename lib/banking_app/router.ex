defmodule BankingApp.Router do
  use Commanded.Commands.Router

  alias BankingApp.Accounts.Aggregates.User
  alias BankingApp.Accounts.Commands.RegisterUser

  alias BankingApp.Bank.Aggregates.Account
  alias BankingApp.Bank.Commands.OpenAccount

  alias BankingApp.Support.Middleware.{Validate,Uniqueness}

  middleware Validate
  middleware Uniqueness

  dispatch [RegisterUser], to: User, identity: :user_uuid
  dispatch [OpenAccount], to: Account, identity: :account_uuid
end
