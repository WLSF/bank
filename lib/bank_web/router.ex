defmodule BankWeb.Router do
  use BankWeb, :router

  alias BankWeb.AuthMiddleware

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug AuthMiddleware
  end

  scope "/api", BankWeb do
    pipe_through :api

    post "/login", AccountController, :login
    resources "/accounts", AccountController, only: [:create]
  end

  scope "/api", BankWeb do
    pipe_through [:api, :jwt_authenticated]

    resources "/indications", IndicationsController, only: [:index]
  end
end
