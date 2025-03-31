defmodule EtlWeb.Repo.Migrations.CreateSensorReadings do
  use Ecto.Migration

  def change do
    create table(:sensor_readings) do
      add(:sensor_id, :integer)
      add(:timestamp, :utc_datetime)
      add(:temperature, :float)
      add(:voltage, :float)
      add(:is_active, :boolean)
      add(:location, :string)
      add(:operator, :string)

      timestamps()
    end
  end
end
