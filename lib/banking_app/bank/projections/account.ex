defmodule BankingApp.Bank.Projections.Account do
  use Ecto.Schema

  alias BankingApp.Bank.Projections.Account

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "bank_accounts" do
    field :code, :string
    field :user_uuid, :binary_id
    field :balance_cents, :integer
    field :balance, Money.Ecto.Amount.Type, virtual: true

    timestamps()
  end

  def assign_balance(%Account{balance_cents: balance_cents} = account)
  when is_integer(balance_cents)
  do
    %Account{account | balance: Money.new(balance_cents)}
  end

  def assign_balance(account), do: account
end
