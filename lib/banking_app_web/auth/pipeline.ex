defmodule BankingAppWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :banking_app,
    module: BankingAppWeb.Auth.Guardian,
    error_handler: BankingAppWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Token"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug :assign_current_user

  defp assign_current_user(conn, _) do
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> assign(:current_user, current_user)
  end
end
