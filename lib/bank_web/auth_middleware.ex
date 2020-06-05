defmodule BankWeb.AuthMiddleware do
  use Guardian.Plug.Pipeline, otp_app: :bank,
  module: Bank.Guardian,
  error_handler: BankWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end