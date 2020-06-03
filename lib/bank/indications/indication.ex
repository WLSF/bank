defmodule Bank.Indications.Indication do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bank.Accounts.Account

  schema "indications" do
    field :referral_code, :integer

    belongs_to :src, Account
    belongs_to :dest, Account

    timestamps()
  end

  @doc false
  def changeset(indication, attrs) do
    indication
    |> cast(attrs, [:src_id, :dest_id, :referral_code])
    |> validate_required([:src_id, :dest_id, :referral_code])
  end
end
