defmodule Bank.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Bank.Repo

  alias Bank.Accounts.Account

  def list_accounts do
    Repo.all(Account)
  end

  def create_or_update_account(attrs \\ %{}) do
    account = 
      attrs
      |> Map.get("cpf")
      |> get_by_cpf()

    case account do
      nil -> create_account(attrs)
      _   -> update_account(account, attrs)
    end
  end

  defp get_by_cpf(cpf), do: Repo.get_by(Account, cpf: cpf)

  defp create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  defp update_account(account, attrs \\ %{}) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end
end
