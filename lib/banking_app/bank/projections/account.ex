defmodule BankingApp.Bank.Projections.Account do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "bank_accounts" do
    field :code, :string
    field :user_uuid, :binary_id
    field :balance_cents, :integer

    timestamps()
  end
end
