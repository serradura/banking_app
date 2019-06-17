defmodule BankingApp.Repo do
  use Ecto.Repo,
    otp_app: :banking_app,
    adapter: Ecto.Adapters.Postgres
end
