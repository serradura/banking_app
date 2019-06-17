defmodule BankingApp.Accounts.Aggregates.UserTest do
  use BankingApp.AggregateCase, aggregate: BankingApp.Accounts.Aggregates.User

  alias BankingApp.Accounts.Events.UserRegistered

  describe "register user" do
    @tag :unit
    test "should succeed when valid" do
      user_uuid = UUID.uuid4()

       assert_events build(:register_user, user_uuid: user_uuid), [
        %UserRegistered{
          user_uuid: user_uuid,
          email: "rodrigo.serradura@gmail.com",
          hashed_password: "$2b$12$ysY/4oz52SCBOYbfywpBe.lJWOslcXVGBbuCcRWUaMPuFjUgp72hq",
        }
      ]
    end
  end
end
