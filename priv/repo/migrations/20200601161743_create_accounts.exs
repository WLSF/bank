defmodule Bank.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :email, :string
      add :cpf, :string
      add :birth_date, :date
      add :gender, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :referral_code, :integer

      timestamps()
    end

    create unique_index(:accounts, [:cpf])
  end
end
