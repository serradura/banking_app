defmodule BankingApp.AuthTest do
  use ExUnit.Case, async: true

  alias BankingApp.Auth

  describe "password hashing" do
    setup do
      [password: "rodrigoserradura"]
    end

    test "hashes a password", %{password: password} do
      refute Auth.hash_password(password) == password
    end

    test "validates a password", %{password: password} do
      hash = "$2b$12$XbrBoDW/NKVWWKAVrBd0KuzeO.b50blr7rb41T9.F.CtKujmdv3De"

      assert Auth.validate_password(password, hash)
    end
  end
end
