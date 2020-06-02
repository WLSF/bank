defmodule BankWeb.AccountController do
  use BankWeb, :controller

  alias Bank.Accounts
  alias Bank.Accounts.Account

  action_fallback BankWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_or_update_account(account_params) do
      conn
      |> put_status(:created)
      |> render("show.json", account: account)
    end
  end
end
