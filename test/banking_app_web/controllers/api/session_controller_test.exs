defmodule BankingAppWeb.API.SessionControllerTest do
  use BankingAppWeb.ConnCase

  alias BankingAppWeb.Router.Helpers, as: Routes
  alias BankingApp.Accounts

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"),
          user_data: BankingApp.Factory.build(:user_with_password)}
  end

  describe "authenticate user" do
    @tag :web
    test "creates session and renders session when data is valid", %{conn: conn, user_data: user_data} do
      register_user(user_data)

      conn = post conn, Routes.session_path(conn, :create), user: %{
        email: user_data.email,
        password: user_data.password
      }

      json = json_response(conn, 201)["data"]
      token = json["token"]
      inserted_at = json["inserted_at"]

      assert json == %{
        "email" => user_data.email,
        "token" => token,
        "inserted_at" => inserted_at
      }

      assert BankingAppWeb.Auth.JWT.valid?(token)
    end

    @tag :web
    test "does not create session and renders errors when password does not match", %{conn: conn, user_data: user_data} do
      register_user(user_data)

      conn = post conn, Routes.session_path(conn, :create), user: %{
        email: user_data.email,
        password: "invalidpassword"
      }

      assert json_response(conn, 422)["errors"] == %{
        "email or password" => ["is invalid"]
      }
    end

    @tag :web
    test "does not create session and renders errors when user not found", %{conn: conn, user_data: user_data} do
      conn = post conn, Routes.session_path(conn, :create), user: %{
        email: "doesnotexist",
        password: user_data.password
      }

      assert json_response(conn, 422)["errors"] == %{
        "email or password" => ["is invalid"]
      }
    end
  end

  defp register_user(user_attrs),
  do:  Accounts.register_user(user_attrs)
end
