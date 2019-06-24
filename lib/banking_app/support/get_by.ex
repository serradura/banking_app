defmodule BankingApp.Support.GetBy do
  def get_by(repo, schema, options) do
    case repo.get_by(schema, options) do
      nil        -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
