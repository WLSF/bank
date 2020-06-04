defmodule BankWeb.Repositories.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Bank.Repo

  alias BankWeb.Models.Account
  alias BankWeb.Utils.MapReader

  def list_accounts do
    Repo.all(Account)
  end

  def create_or_update_account(attrs \\ %{}) do
    account =
      attrs
      |> MapReader.get("cpf")
      |> get_by_cpf()

    case account do
      nil -> create_account(attrs)
      _   -> update_account(account, attrs)
    end
  end

  def get_by_cpf(nil), do: nil
  def get_by_cpf(cpf), do: Repo.get_by(Account, cpf: cpf)

  def get_by_code(code), do: Repo.get_by(Account, referral_code: code)

  defp create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
    |> generate_code_if_account_is_complete()
  end

  defp update_account(account, attrs \\ %{}) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
    |> generate_code_if_account_is_complete()
  end

  defp generate_code_if_account_is_complete(result = {:error, account}), do: result
  defp generate_code_if_account_is_complete(result = {:ok, account}) do
    case Account.account_complete?(account) do
      true  -> account
                |> Account.add_referral_code
                |> Repo.update()

      false -> result
    end
  end
end
