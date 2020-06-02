defmodule BankWeb.AccountHelpers do
  def get_status(account) do
    result = account.name && account.email && account.birth_date && account.gender && account.city && account.state && account.country

    case result do
      nil -> "incompleto"
      _   -> "completo"
    end
  end
end
