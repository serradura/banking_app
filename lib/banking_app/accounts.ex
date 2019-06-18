
defmodule BankingApp.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias BankingApp.{Repo,Router}
  alias BankingApp.Accounts.Commands.RegisterUser
  alias BankingApp.Accounts.Projections.User

  def get_user(uuid),
  do: get_by(User, uuid: uuid)

  def get_user_by_email(email),
  do: get_by(User, email: email)

  def register_user(attrs \\ %{}) do
    with register_user <- RegisterUser.build(attrs),
         :ok           <- Router.dispatch(register_user, consistency: :strong) do
      get_user(register_user.user_uuid)
    else
      reply -> reply
    end
  end

  defp get_by(schema, options) do
    case Repo.get_by(schema, options) do
      nil        -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
