defmodule BankWeb.IndicationsController do
  use BankWeb, :controller

  import BankWeb.Utils.Auth, only: [current_user: 1]
  alias BankWeb.Repositories.Indications

  action_fallback BankWeb.FallbackController

  def index(conn, _params) do
    with {:ok, indications} <- current_user(conn) |> Indications.list_indications_from_account() do
      conn
      |> render("index.json", indications: indications)
    end
  end
end
