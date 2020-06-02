defmodule BankWeb.IndicationsController do
  use BankWeb, :controller

  action_fallback BankWeb.FallbackController

  def index(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> json(%{ message: "Essa função só pode ser acessada por contas finalizadas" })
  end
end
