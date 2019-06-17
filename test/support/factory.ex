defmodule BankingApp.Factory do
  use ExMachina

   def user_factory do
    %{
      email: "rodrigo.serradura@gmail.com",
      hashed_password: "$2b$12$ysY/4oz52SCBOYbfywpBe.lJWOslcXVGBbuCcRWUaMPuFjUgp72hq",
    }
  end

  def user_with_password_factory do
    build(:user)
    |> Map.put(:password, "serradura.rodrigo")
  end

   def register_user_factory do
    BankingApp.Accounts.Commands.RegisterUser
    |> struct(build(:user_with_password))
  end
end
