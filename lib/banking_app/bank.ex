defmodule BankingApp.Bank do
  @moduledoc """
  The Bank context.
  """

  import BankingApp.Support.GetBy, only: [get_by: 3]

  alias BankingApp.{Repo,Router}
  alias BankingApp.Bank.Commands.OpenAccount
  alias BankingApp.Bank.Projections.Account
  alias BankingApp.Accounts.Projections.User

  def get_account(%User{} = user),
  do: get_account_by(user_uuid: user.uuid)

  def get_account(uuid),
  do: get_account_by(uuid: uuid)

  def open_account(%{user_uuid: _} = attrs) do
    with cmd <- OpenAccount.build(attrs),
         :ok <- Router.dispatch(cmd, consistency: :strong) do
      get_account(cmd.account_uuid)
    else
      reply -> reply
    end
  end

  defp get_account_by(options) do
    case get_by(Repo, Account, options) do
      {:ok, account}    -> {:ok, Account.assign_balance(account)}
      {:error, message} -> {:error, message}
    end
  end
end
