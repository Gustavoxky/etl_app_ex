defmodule EtlWeb.Repo.Migrations.CreateOperatorsAndLocations do
  use Ecto.Migration

  def change do
    create table(:operators) do
      add(:name, :string, null: false)
      timestamps()
    end

    create(unique_index(:operators, [:name]))

    create table(:locations) do
      add(:name, :string, null: false)
      timestamps()
    end

    create(unique_index(:locations, [:name]))

    alter table(:sensor_readings) do
      remove(:operator)
      remove(:location)
      add(:operator_id, references(:operators, on_delete: :nothing))
      add(:location_id, references(:locations, on_delete: :nothing))
    end
  end
end
