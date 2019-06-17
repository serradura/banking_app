defmodule BankingApp.Accounts.Events.UserRegistered do
  @derive {Inspect, only: [:user_uuid, :email]}
  @derive [Jason.Encoder]

   defstruct [
    :user_uuid,
    :email,
    :hashed_password,
  ]
end
