defmodule BankingAppWeb.PageController do
  use BankingAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
