defmodule BankingAppWeb.AccountControllerTest do
  use BankingAppWeb.ConnCase

  import BankingAppWeb.ConnHelpers

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "get user account" do
    @tag :web
    test "should return user bank account when authenticated", %{conn: conn} do
      conn = get authenticated_conn(conn), Routes.account_path(conn, :show)
      json = json_response(conn, 200)["data"]
      inserted_at = json["inserted_at"]
      account_code = json["code"]

      assert json == %{
        "code" => account_code,
        "inserted_at" => inserted_at,
        "balance_cents" => 100_000,
        "balance" => "R$ 1.000,00"
      }
    end

    @tag :web
    test "should not return user bank account when unauthenticated", %{conn: conn} do
      conn = get conn, Routes.account_path(conn, :show)
      body = response(conn, 401)

      assert body == "{\"message\":\"unauthenticated\"}"
    end
  end
end
