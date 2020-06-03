defmodule Bank.Repo.Migrations.CreateIndications do
  use Ecto.Migration

  def change do
    create table(:indications) do
      add :sender_id, references(:accounts, on_delete: :delete_all)
      add :receiver_id, references(:accounts, on_delete: :delete_all)

      timestamps()
    end

    create index(:indications, [:sender_id])
    create index(:indications, [:receiver_id])
  end
end
