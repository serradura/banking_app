defmodule BankingAppWeb.API.AccountController do
  use BankingAppWeb, :controller
  use BankingAppWeb.CurrentUser

  alias BankingApp.Bank

  action_fallback BankingAppWeb.API.FallbackController

  def show(conn, _params, current_user) do
    {:ok, account} = Bank.get_account(current_user)

    conn
    |> put_status(:ok)
    |> put_view(BankingAppWeb.API.AccountView)
    |> render("show.json", account: account)
  end
end
