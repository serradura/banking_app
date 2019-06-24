defmodule BankingAppWeb.Auth.Guardian do
  use Guardian, otp_app: :banking_app

  alias BankingApp.Accounts
  alias BankingApp.Accounts.Projections.User

  def subject_for_token(%User{} = user, _claims),
  do: {:ok, to_string(user.uuid)}

  def subject_for_token(_, _),
  do: {:error, "Unknown resource type"}

  def resource_from_claims(%{"sub" => uuid}),
  do: Accounts.get_user(uuid)

  def resource_from_claims(_claims),
  do: {:error, "Unknown resource type"}
end
