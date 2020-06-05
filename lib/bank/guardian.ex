defmodule Bank.Guardian do
  use Guardian, otp_app: :bank

  def subject_for_token(account, _claims) do
    sub = to_string(account.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = BankWeb.Repositories.Accounts.get!(id)
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end