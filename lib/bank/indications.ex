defmodule Bank.Indications do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Bank.Repo
  
  alias Bank.{
    Accounts.Account,
    Indications.Indication
  }

  def list_indications_from_account(sender) do
    query = from i in Indication,
              join: a in Account, on: a.id == i.receiver_id,
              where: i.sender_id == ^sender.id,
              select: {a.id, a.name}

    Repo.all(query)
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
end
