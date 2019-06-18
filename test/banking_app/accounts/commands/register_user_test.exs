defmodule BankingApp.Accounts.Commands.RegisterUserTest do
  use ExUnit.Case, async: true

  alias BankingApp.Auth
  alias BankingApp.Accounts.Commands.RegisterUser

  import BankingApp.Factory

  describe "validations" do
    def validation_error(func, options \\ []) when is_function(func) do
      options
      |> Enum.into(%{})
      |> RegisterUser.new()
      |> Vex.results()
      |> Enum.any?(func)
    end

    @tag :unit
    test "email" do
      invalid_email = fn
        {:error, :email, :uniqueness, "must be a valid email"} -> true
        {:error, _, _, _} -> false
        {:ok, _, _} -> false
      end

      assert validation_error(invalid_email, email: nil)
      assert validation_error(invalid_email, email: "a")
      assert validation_error(invalid_email, email: "a@b")

      refute validation_error(invalid_email, email: "a@b.com")
    end

    @tag :unit
    test "user_uuid" do
      invalid_uuid = fn
        {:error, :user_uuid, :uuid, "must be a valid UUID string"} -> true
        {:error, _, _, _} -> false
        {:ok, _, _} -> false
      end

      assert validation_error(invalid_uuid, user_uuid: nil)
      assert validation_error(invalid_uuid, user_uuid: "213")

      refute validation_error(invalid_uuid, user_uuid: UUID.uuid4())
    end

    @tag :unit
    test "hashed_password" do
      invalid_hashed_password = fn
        {:error, :hashed_password, :presence, "must be present"} -> true
        {:error, :hashed_password, :string, "must be a string"} -> true
        {:error, _, _, _} -> false
        {:ok, _, _} -> false
      end

      assert validation_error(invalid_hashed_password, hashed_password: nil)
      assert validation_error(invalid_hashed_password, hashed_password: "")

      refute validation_error(invalid_hashed_password, hashed_password: "123")
    end
  end

  describe "build" do
    @tag :unit
    test "should convert email address to lowercase" do
      attrs = build(:user_with_password, email: "FOO@BAR.COM")

      assert %RegisterUser{email: "foo@bar.com"} = RegisterUser.build(attrs)
    end

    @tag :unit
    test "should encrypt the password and clear its plain text version" do
      attrs = build(:user_with_password)

      assert %RegisterUser{password: nil, hashed_password: hash} = RegisterUser.build(attrs)
      assert Auth.validate_password(attrs.password, hash)
    end

    @tag :unit
    test "should assigns an UUID in user_uuid property" do
      attrs = build(:user_with_password)

      assert %RegisterUser{user_uuid: uuid} = RegisterUser.build(attrs)
      assert {:ok, _} = UUID.info(uuid)
    end
  end
end
