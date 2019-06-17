defmodule BankingApp.Accounts.Projections.User do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "accounts_users" do
    field :email, :string
    field :hashed_password, :string

    timestamps()
  end
end
