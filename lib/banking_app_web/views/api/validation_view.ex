defmodule BankingAppWeb.API.ValidationView do
  use BankingAppWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end
