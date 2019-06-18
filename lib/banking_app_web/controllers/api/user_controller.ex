defmodule BankingAppWeb.API.UserController do
  use BankingAppWeb, :controller

  alias BankingApp.Accounts

  action_fallback BankingAppWeb.API.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
