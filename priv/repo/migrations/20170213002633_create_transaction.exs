defmodule Bgt.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :float
      add :description, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:transactions, [:user_id])

  end
end
