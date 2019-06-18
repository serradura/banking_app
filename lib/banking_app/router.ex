defmodule BankingApp.Router do
  use Commanded.Commands.Router

  alias BankingApp.Accounts.Aggregates.User
  alias BankingApp.Accounts.Commands.RegisterUser
  alias BankingApp.Support.Middleware.{Validate,Uniqueness}

  middleware Validate
  middleware Uniqueness

  dispatch [RegisterUser], to: User, identity: :user_uuid
end
