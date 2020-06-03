defmodule Bank.Indications do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Bank.Repo

  alias Bank.Indications.Indication

  def list_indications_from_account(indication) do
    query = from i in Indication,
      where: i.src_id == ^indication.id,
      select: i

    Repo.all(query)
  end

  def create_indication(indicated, indication, referral_code) do
    attrs = %{
      src_id: indication.id,
      dest_id: indicated.id,
      referral_code: referral_code
    }

    %Indication{}
    |> Indication.changeset(attrs)
    |> Repo.insert()
  end
end
