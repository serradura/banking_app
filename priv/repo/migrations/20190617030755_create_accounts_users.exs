defmodule BankingApp.Repo.Migrations.CreateAccountsUsers do
  use Ecto.Migration

  def change do
    create table(:accounts_users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :email, :string
      add :hashed_password, :string

      timestamps()
    end

    create unique_index(:accounts_users, [:email])
  end
end
