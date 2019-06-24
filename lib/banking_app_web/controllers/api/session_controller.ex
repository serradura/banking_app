defmodule BankingAppWeb.API.SessionController do
  use BankingAppWeb, :controller

  alias BankingApp.Auth

  import BankingAppWeb.Auth.JWT

  action_fallback BankingAppWeb.FallbackController

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:ok, user} <- Auth.authenticate(email, password),
         {:ok, jwt}  <- generate_jwt(user) do
        conn
        |> put_status(:created)
        |> put_view(BankingAppWeb.API.UserView)
        |> render("show.json", user: user, jwt: jwt)
    else
      {:error, :unauthenticated} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BankingAppWeb.API.ValidationView)
        |> render("error.json", errors: %{
          "email or password" => ["is invalid"]
        })
    end
  end
end
