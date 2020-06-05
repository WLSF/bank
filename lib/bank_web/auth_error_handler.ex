defmodule BankWeb.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{message: "Você não tem permissão para isso"})
    send_resp(conn, :unauthorized, body)
  end
end
