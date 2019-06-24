defmodule BankingApp.Repo.Migrations.CreateBankAccounts do
  use Ecto.Migration

  def change do
    create table(:bank_accounts, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :code, :string
      add :user_uuid, :uuid
      add :balance_cents, :integer

      timestamps()
    end

    create unique_index(:bank_accounts, [:code])
    create unique_index(:bank_accounts, [:user_uuid])
  end
end
