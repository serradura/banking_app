defmodule BankingApp.Accounts.Commands.RegisterUser do
  @derive {Inspect, only: [:user_uuid, :email]}

  defstruct [
    :user_uuid,
    :email,
    :password,
    :hashed_password,
  ]

  use ExConstructor
end
