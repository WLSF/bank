defmodule Bank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bank.Indications.Indication
  alias Bank.InvitationCodeGenerator, as: CodeGenerator

  schema "accounts" do
    field :birth_date, :date
    field :city, :string
    field :country, :string
    field :cpf, :string
    field :email, :string
    field :gender, :string
    field :name, :string
    field :referral_code, :integer
    field :state, :string

    has_many :indications, Indication, foreign_key: "src_id"
    has_one :indicated, Indication, foreign_key: "dest_id"

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :email, :cpf, :birth_date, :gender, :city, :state, :country])
    |> validate_required([:cpf])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:cpf])
  end

  def account_complete?(account) do
    result = account.name && account.email && account.birth_date && account.gender && account.city && account.state && account.country

    case result do
      nil -> false
      _   -> true
    end
  end

  def add_referral_code(account) do
    account
    |> change(referral_code: CodeGenerator.call())
  end
end
