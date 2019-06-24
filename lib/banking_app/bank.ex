defmodule BankingApp.Bank do
  @moduledoc """
  The Bank context.
  """

  import BankingApp.Support.GetBy, only: [get_by: 3]

  alias BankingApp.{Repo,Router}
  alias BankingApp.Bank.Commands.OpenAccount
  alias BankingApp.Bank.Projections.Account

  def get_account(uuid),
  do: get_by(Repo, Account, uuid: uuid)

  def open_account(%{user_uuid: _} = attrs) do
    with cmd <- OpenAccount.build(attrs),
         :ok <- Router.dispatch(cmd, consistency: :strong) do
      get_account(cmd.account_uuid)
    else
      reply -> reply
    end
  end
end
