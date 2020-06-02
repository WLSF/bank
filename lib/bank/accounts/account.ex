defmodule Bank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

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

  def get_status(account) do
    result = account.name && account.email && account.birth_date && account.gender && account.city && account.state && account.country

    case result do
      nil -> "incompleto"
      _   -> "completo"
    end
  end
end
