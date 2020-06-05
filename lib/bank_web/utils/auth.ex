defmodule BankWeb.Utils.Auth do
  alias Bank.Guardian
  alias BankWeb.Repositories.Accounts

  def login(email, cpf) do
    case validate(email, cpf) do
      nil -> {:error, :wrong_login}
      account -> Guardian.encode_and_sign(account)
    end
  end

  def validate(email, cpf) do
    Accounts.get_by_email_and_cpf(email, cpf)
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end