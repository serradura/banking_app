defmodule BankingApp.BankTest do
  use BankingApp.DataCase

  alias BankingApp.Bank

  describe "open account" do
    alias BankingApp.Bank.Projections.Account

    @tag :integration
    test "should succeed with valid data" do
      attrs = %{user_uuid: UUID.uuid4()}

      assert {:ok, %Account{code: code} = account} = Bank.open_account(attrs)

      assert account.user_uuid == attrs.user_uuid
      assert {:ok, _} = UUID.info(account.uuid)
      assert String.valid?(code) and code != ""
      assert account.balance_cents == 100_000
    end
  end
end
