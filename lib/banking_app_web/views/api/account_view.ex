defmodule BankingAppWeb.API.AccountView do
  use BankingAppWeb, :view
  alias BankingAppWeb.API.AccountView

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    balance = account.balance |> Money.to_string()

    %{code: account.code,
      balance: balance,
      balance_cents: account.balance_cents,
      inserted_at: account.inserted_at}
  end
end
