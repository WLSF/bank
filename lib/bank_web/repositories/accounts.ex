defmodule BankWeb.Repositories.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Bank.Repo

  alias BankWeb.Models.Account
  alias BankWeb.Utils.MapReader

  def get!(id), do: Repo.get!(Account, id)
  def get_by_cpf(nil), do: nil
  def get_by_cpf(cpf), do: Account |> Repo.get_by(cpf: cpf)
  def get_by_code(code), do: Account |> Repo.get_by(referral_code: code)
  def get_by_email_and_cpf(email, cpf), do: Account |> Repo.get_by([email: email, cpf: cpf])

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

  defp create_account(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
    |> generate_code_if_account_is_complete()
  end

  defp update_account(account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
    |> generate_code_if_account_is_complete()
  end

  defp generate_code_if_account_is_complete(result = {:error, _account}), do: result
  defp generate_code_if_account_is_complete(result = {:ok, account}) do
    case Account.account_complete?(account) do
      true  -> account
                |> Account.add_referral_code
                |> Repo.update()

      false -> result
    end
  end
end
