defmodule BankWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BankWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BankWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{message: "Você não tem permissão para isso"})
  end

  def call(conn, {:error, :wrong_login}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{message: "Login incorreto"})
  end

  def call(conn, {:error, :incomplete_account}) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: "Sua conta não está completa"})
  end
end
