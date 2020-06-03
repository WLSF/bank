defmodule BankWeb.IndicationsController do
  use BankWeb, :controller

  alias Bank.Accounts
  alias Bank.Indications
  alias Bank.Indications.Indication

  action_fallback BankWeb.FallbackController

  # WIP
  def index(conn, %{"cpf_number" => number}) do
    account = Accounts.get_by_cpf(number)
    Indications.list_indications_from_account(account)
    conn
    |> put_status(:unauthorized)
    |> json(%{ message: "Essa função só pode ser acessada por contas finalizadas" })
  end
end
