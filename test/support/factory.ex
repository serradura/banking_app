defmodule BankingApp.Factory do
  use ExMachina

   alias BankingApp.Accounts.Commands.RegisterUser

   def user_factory do
    # hashed_password == "serradura.rodrigo"
    %{
      email: "rodrigo.serradura@gmail.com",
      hashed_password: "$2b$12$ysY/4oz52SCBOYbfywpBe.lJWOslcXVGBbuCcRWUaMPuFjUgp72hq",
    }
  end

   def register_user_factory do
    struct(RegisterUser, build(:user))
  end
end
