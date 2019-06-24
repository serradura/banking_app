defmodule BankingApp.Bank.Commands.OpenAccount do
  defstruct [
    :user_uuid,
    :account_uuid,
    :account_code
  ]

  use ExConstructor
  use Vex.Struct

  alias BankingApp.Bank.Commands.OpenAccount

  validates :user_uuid, uuid: true
  validates :account_uuid, uuid: true
  validates :account_code, presence: true

  def build(%{user_uuid: user_uuid} = attrs) do
    attrs
    |> new()
    |> assign_user_uuid(user_uuid)
    |> assign_account_uuid()
    |> assign_account_code()
  end

  defp assign_user_uuid(%OpenAccount{} = cmd, user_uuid),
  do:  %OpenAccount{cmd | user_uuid: user_uuid}

  defp assign_account_uuid(%OpenAccount{} = cmd),
  do:  %OpenAccount{cmd | account_uuid: UUID.uuid4()}

  defp assign_account_code(%OpenAccount{} = cmd) do
    account_code = UUID.uuid4() |> String.split("-") |> List.first()

    %OpenAccount{cmd | account_code: account_code}
  end
end
