defmodule BankingApp.Accounts.Projectors.User do
  use Commanded.Projections.Ecto,
      name: "Accounts.Projectors.User",
      consistency: :strong

  alias BankingApp.Accounts.Events.UserRegistered
  alias BankingApp.Accounts.Projections.User

  project(%UserRegistered{} = registered, fn multi ->
    Ecto.Multi.insert(multi, :user, %User{
      uuid: registered.user_uuid,
      email: registered.email,
      hashed_password: registered.hashed_password,
    })
  end)
end
