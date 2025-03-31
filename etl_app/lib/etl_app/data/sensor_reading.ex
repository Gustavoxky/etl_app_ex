defmodule EtlApp.Data.SensorReading do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :id,
             :sensor_id,
             :timestamp,
             :temperature,
             :voltage,
             :is_active,
             :location,
             :operator,
             :inserted_at,
             :updated_at
           ]}

  schema "sensor_readings" do
    field(:sensor_id, :integer)
    field(:timestamp, :utc_datetime)
    field(:temperature, :float)
    field(:voltage, :float)
    field(:is_active, :boolean)
    field(:location, :string)
    field(:operator, :string)

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
      :location,
      :operator
    ])
    |> validate_required([
      :sensor_id,
      :timestamp,
      :temperature,
      :voltage,
      :is_active,
      :location,
      :operator
    ])
  end
end
