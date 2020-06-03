defmodule Bank.Indications.Indication do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bank.Accounts.Account

  schema "indications" do
    belongs_to :sender, Account
    belongs_to :receiver, Account

    timestamps()
  end

  @doc false
  def changeset(indication, attrs) do
    indication
    |> cast(attrs, [:sender_id, :receiver_id])
    |> validate_required([:sender_id, :receiver_id])
  end
end
