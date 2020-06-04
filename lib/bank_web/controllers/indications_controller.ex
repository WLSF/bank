defmodule BankWeb.IndicationsController do
  use BankWeb, :controller

  alias BankWeb.Repositories.{
    Accounts,
    Indications
  }

  action_fallback BankWeb.FallbackController

  # WIP
  def index(conn, %{"cpf_number" => number}) do
    indications = number
    |> Accounts.get_by_cpf()
    |> Indications.list_indications_from_account()

    conn
    |> put_status(:ok)
    |> render("index.json", indications: indications)
  end
end
