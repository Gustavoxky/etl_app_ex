defmodule EtlWeb.Data.SensorReading do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sensor_readings" do
    field(:sensor_id, :integer)
    field(:timestamp, :utc_datetime)
    field(:temperature, :float)
    field(:voltage, :float)
    field(:is_active, :boolean)

    belongs_to(:operator, EtlWeb.Data.Operator)
    belongs_to(:location, EtlWeb.Data.Location)

    timestamps()
  end

  def changeset(reading, attrs) do
    reading
    |> cast(attrs, [
      :sensor_id,
      :timestamp,
      :temperature,
      :voltage,
      :is_active,
      :operator_id,
      :location_id
    ])
    |> validate_required([
      :sensor_id,
      :timestamp,
      :temperature,
      :voltage,
      :is_active,
      :operator_id,
      :location_id
    ])
  end
end
