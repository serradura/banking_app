defmodule BankingAppWeb.ConnHelpers do
  import Plug.Conn
  import BankingApp.Factory

  def authenticated_conn(conn) do
    with {:ok, user} <- BankingApp.Accounts.register_user(build(:user_with_password)),
         {:ok, jwt}  <- BankingAppWeb.Auth.JWT.generate_jwt(user),
    do:  put_req_header(conn, "authorization", "Token " <> jwt)
  end
end
