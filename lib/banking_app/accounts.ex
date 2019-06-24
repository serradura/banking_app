
defmodule BankingApp.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import BankingApp.Support.GetBy, only: [get_by: 3]

  alias BankingApp.{Repo,Router}
  alias BankingApp.Accounts.Commands.RegisterUser
  alias BankingApp.Accounts.Projections.User

  def get_user(uuid),
  do: get_by(Repo, User, uuid: uuid)

  def get_user_by_email(email),
  do: get_by(Repo, User, email: email)

  def register_user(attrs \\ %{}) do
    with cmd <- RegisterUser.build(attrs),
         :ok <- Router.dispatch(cmd, consistency: :strong) do
      get_user(cmd.user_uuid)
    else
      reply -> reply
    end
  end
end
