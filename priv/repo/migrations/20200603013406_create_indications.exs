defmodule Bank.Repo.Migrations.CreateIndications do
  use Ecto.Migration

  def change do
    create table(:indications) do
      add :src_id, references("accounts")
      add :dest_id, references("accounts")
      add :referral_code, :integer

      timestamps()
    end

    create unique_index(:indications, [:src_id, :dest_id])
  end
end
