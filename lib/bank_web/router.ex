defmodule BankWeb.Router do
  use BankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankWeb do
    pipe_through :api

    resources "/accounts", AccountController, only: [:create]
    resources "/accounts/:cpf_number/indications", IndicationsController, only: [:index]
  end
end
