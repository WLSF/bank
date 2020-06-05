defmodule BankWeb.AccountController do
  use BankWeb, :controller

  alias BankWeb.Utils.Auth
  alias BankWeb.Models.Account
  alias BankWeb.Repositories.{
    Accounts,
    Indications
  }

  action_fallback BankWeb.FallbackController

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

  def login(conn, %{"email" => email, "cpf" => cpf}) do
    with {:ok, token, _claims} <- Auth.login(email, cpf) do
      conn
      |> json(%{jwt: token})
    end
  end
end
