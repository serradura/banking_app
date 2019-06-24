defmodule BankingApp.Factory do
  use ExMachina

  def user_params_factory do
    %{email: "rodrigo.serradura@gmail.com",
      password: "serradura.rodrigo"}
  end

  def user_factory do
    %{hashed_password: "$2b$12$ysY/4oz52SCBOYbfywpBe.lJWOslcXVGBbuCcRWUaMPuFjUgp72hq"}
    |> Map.put(:email, build(:user_params).email)
  end

  def user_with_password_factory do
    build(:user_params)
    |> Map.merge(build(:user))
  end

  def register_user_factory do
    BankingApp.Accounts.Commands.RegisterUser
    |> struct(build(:user_with_password))
  end
end
