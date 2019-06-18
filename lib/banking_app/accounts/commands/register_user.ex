defmodule BankingApp.Accounts.Commands.RegisterUser do
  @derive {Inspect, only: [:user_uuid, :email]}

  defstruct [
    :user_uuid,
    :email,
    :password,
    :hashed_password,
  ]

  use ExConstructor
  use Vex.Struct

  alias BankingApp.{Auth,Accounts}
  alias BankingApp.Accounts.Commands.RegisterUser

  validates :email, uniqueness: [
    prerequisite: :email,
    finder: &Accounts.get_user_by_email/1
  ]
  validates :user_uuid, uuid: true
  validates :hashed_password, presence: true, string: true

  def build(%{} = attrs) do
    attrs
    |> new()
    |> hash_password()
    |> downcase_email()
    |> assign_user_uuid()
  end

  defp hash_password(%RegisterUser{password: password} = cmd) do
    hashed_password = Auth.hash_password(password)

    %RegisterUser{cmd | password: nil, hashed_password: hashed_password}
  end

  defp downcase_email(%RegisterUser{email: email} = cmd),
  do:  %RegisterUser{cmd | email: String.downcase(email)}

  defp assign_user_uuid(%RegisterUser{user_uuid: nil} = cmd),
  do:  %RegisterUser{cmd | user_uuid: UUID.uuid4()}

  defp assign_user_uuid(%RegisterUser{user_uuid: _} = cmd),
  do:  cmd
end
