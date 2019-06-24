defmodule BankingApp.Bank.Commands.OpenAccountTest do
  use ExUnit.Case, async: true

  alias BankingApp.Bank.Commands.OpenAccount

  describe "validations" do
    def validation_error(func, options \\ []) when is_function(func) do
      options
      |> Enum.into(%{})
      |> OpenAccount.new()
      |> Vex.results()
      |> Enum.any?(func)
    end

    @tag :unit
    test "account_uuid" do
      invalid_uuid = fn
        {:error, :account_uuid, :uuid, "must be a valid UUID string"} -> true
        {:error, _, _, _} -> false
        {:ok, _, _} -> false
      end

      assert validation_error(invalid_uuid, account_uuid: nil)
      assert validation_error(invalid_uuid, account_uuid: "213")

      refute validation_error(invalid_uuid, account_uuid: UUID.uuid4())
    end

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
    test "account_code" do
      invalid_uuid = fn
        {:error, :account_code, :presence, "must be present"} -> true
        {:error, _, _, _} -> false
        {:ok, _, _} -> false
      end

      assert validation_error(invalid_uuid, account_code: nil)
      assert validation_error(invalid_uuid, account_code: "")

      refute validation_error(invalid_uuid, account_code: "123")
    end
  end

  describe "build" do
    @tag :unit
    test "should assigns an UUID in account_uuid property" do
      attrs = %{user_uuid: ""}

      assert %OpenAccount{account_uuid: uuid} = OpenAccount.build(attrs)
      assert {:ok, _} = UUID.info(uuid)
    end

    @tag :unit
    test "should assigns an UUID in user_uuid property" do
      attrs = %{user_uuid: UUID.uuid4()}

      assert %OpenAccount{user_uuid: uuid} = OpenAccount.build(attrs)
      assert {:ok, _} = UUID.info(uuid)
    end

    @tag :unit
    test "should assigns an account code" do
      attrs = %{user_uuid: ""}

      assert %OpenAccount{account_code: code} = OpenAccount.build(attrs)
      assert String.valid?(code) and String.length(code) == 8
    end
  end
end
