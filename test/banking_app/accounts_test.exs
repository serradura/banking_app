defmodule BankingApp.AccountsTest do
  use BankingApp.DataCase

  alias BankingApp.{Auth,Accounts}

  describe "register user" do
    alias BankingApp.Accounts.Projections.User

    @tag :integration
    test "should succeed with valid data" do
      user_attributes = build(:user_with_password)

      assert {:ok, %User{} = user} = Accounts.register_user(user_attributes)

      assert user.email == user_attributes.email
      assert Auth.validate_password(
        user_attributes.password, user.hashed_password
      )
    end
  end
end
