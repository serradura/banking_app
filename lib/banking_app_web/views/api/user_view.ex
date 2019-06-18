defmodule BankingAppWeb.API.UserView do
  use BankingAppWeb, :view
  alias BankingAppWeb.API.UserView

  def render("show.json", %{user: user, jwt: jwt}) do
    user_with_token =
      user
      |> render_one(UserView, "user.json")
      |> Map.merge(%{token: jwt})

     %{data: user_with_token}
  end

  def render("user.json", %{user: user}) do
    %{email: user.email,
      inserted_at: user.inserted_at}
  end
end
