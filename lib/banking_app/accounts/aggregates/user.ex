defmodule BankingApp.Accounts.Aggregates.User do
  @derive {Inspect, only: [:uuid, :email]}

  defstruct [
    :uuid,
    :email,
    :hashed_password,
  ]

  alias BankingApp.Accounts.Aggregates.User
  alias BankingApp.Accounts.Commands.RegisterUser
  alias BankingApp.Accounts.Events.UserRegistered

  @doc """
  Register a new user
  """
  def execute(%User{uuid: nil}, %RegisterUser{} = register) do
    %UserRegistered{
      user_uuid: register.user_uuid,
      email: register.email,
      hashed_password: register.hashed_password,
    }
  end

  # state mutators

  def apply(%User{} = user, %UserRegistered{} = registered) do
    %User{user |
      uuid: registered.user_uuid,
      email: registered.email,
      hashed_password: registered.hashed_password,
    }
  end
end
