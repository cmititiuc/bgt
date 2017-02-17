defmodule Bgt.Repo.Migrations.ConvertAmountFromFloatToDecimal do
  use Ecto.Migration

  def up do
    alter table(:transactions) do
      modify :amount, :decimal
    end
  end

  def down do
    alter table(:transactions) do
      modify :amount, :float
    end
  end
end
