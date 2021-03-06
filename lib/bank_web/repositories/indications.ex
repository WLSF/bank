defmodule BankWeb.Repositories.Indications do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Bank.Repo
  
  alias BankWeb.Models.{
    Account,
    Indication
  }

  def list_indications_from_account(sender) do
    if account_complete?(sender) do
      query = from i in Indication,
                join: a in Account, on: a.id == i.receiver_id,
                where: i.sender_id == ^sender.id,
                select: {a.id, a.name}

      {:ok, Repo.all(query)}
    else
      {:error, :incomplete_account}
    end
  end

  def create_indication(sender, receiver) do
    unless indication_exists?(sender, receiver) do
      attrs = %{
        sender_id: sender.id,
        receiver_id: receiver.id
      }

      %Indication{}
      |> Indication.changeset(attrs)
      |> Repo.insert()
    end
  end

  def indication_exists?(sender, receiver) do
    Indication
    |> Repo.get_by([sender_id: sender.id, receiver_id: receiver.id])
  end

  def account_complete?(sender) do
    sender && sender.referral_code
  end
end
