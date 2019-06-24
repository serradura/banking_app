defmodule BankingAppWeb.API.UserControllerTest do
  use BankingAppWeb.ConnCase

  alias BankingApp.Accounts

  import BankingApp.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register user" do
    @tag :web
    test "should create and return user when data is valid", %{conn: conn} do
      conn = post conn, Routes.user_path(conn, :create), user: build(:user_params)
      json = json_response(conn, 201)["data"]
      token = json["token"]
      inserted_at = json["inserted_at"]

      assert json == %{
        "email" => "rodrigo.serradura@gmail.com",
        "token" => token,
        "inserted_at" => inserted_at,
      }

      assert BankingAppWeb.Auth.JWT.valid?(token)
    end

    @tag :web
    test "should not create user and render errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.user_path(conn, :create), user: build(:user_params, email: "")
      assert json_response(conn, 422)["errors"] == %{
        "email" => ["must be a valid email"]
      }
    end

    @tag :web
    test "should not create user and render errors when username has been taken", %{conn: conn} do
      user_params = build(:user_params)

      assert {:ok, _} = Accounts.register_user build(:user_params)

      # attempt to register the same username
      conn = post conn, Routes.user_path(conn, :create), user: user_params

      assert json_response(conn, 422)["errors"] == %{
        "email" => ["has already been taken"]
      }
    end
  end
end
