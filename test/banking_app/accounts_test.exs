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
    test "should fail when email already taken and return error" do
      user_attrs = build(:user_with_password)

      assert {:ok, %User{}} = Accounts.register_user(user_attrs)
      assert {:error, :validation_failure, errors} = Accounts.register_user(user_attrs)

      assert Enum.member?(errors.email, "has already been taken")
    end

    @tag :integration
    test "should fail when registering identical email at same time and return error" do
      1..2
      |> Enum.map(fn _ -> Task.async(fn -> Accounts.register_user(build(:user_with_password)) end) end)
      |> Enum.map(&Task.await/1)
    end
  end
end
