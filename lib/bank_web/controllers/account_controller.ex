defmodule BankWeb.AccountController do
  use BankWeb, :controller

  alias BankWeb.Models.Account
  alias BankWeb.Repositories.{
    Accounts,
    Indications
  }

  action_fallback BankWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_or_update_account(account_params) do
      if referral_code = account_params["referral_code"] do
        sender = Accounts.get_by_code(referral_code)
        if sender, do: Indications.create_indication(sender, account)
        
        unless sender do
          conn
          |> put_status(:bad_request)
          |> json(%{message: "Código de referência inválido"})
        end
      end

      conn
      |> put_status(:created)
      |> render("show.json", account: account)
    end
  end
end
