defmodule BankingApp.Bank.Aggregates.AccountTest do
  use BankingApp.AggregateCase, aggregate: BankingApp.Bank.Aggregates.Account

  alias BankingApp.Bank.Events.AccountOpened

  describe "open account" do
    @tag :unit
    test "should succeed when valid" do
      user_uuid = UUID.uuid4()
      account_uuid = UUID.uuid4()
      open_account = build(:open_account, user_uuid: user_uuid, account_uuid: account_uuid)

       assert_events open_account, [
        %AccountOpened{
          user_uuid: user_uuid,
          account_uuid: account_uuid,
          account_code: open_account.account_code,
          initial_balance_cents: 100_000
        }
      ]
    end
  end
end
