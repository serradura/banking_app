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

    @tag :integration
    test "should fail with invalid data and return error" do
      user_with_password = build(:user_with_password)

      Accounts.register_user(user_with_password)

      assert {:error, :validation_failure, errors} = Accounts.register_user(user_with_password)

      assert errors == %{email: ["has already been taken"]}
    end
  end
end
