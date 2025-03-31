defmodule EtlWebWeb.ReadingsController do
  use EtlWebWeb, :controller

  alias EtlWeb.Repo
  alias EtlWeb.Data.SensorReading

  def index(conn, _params) do
    readings =
      SensorReading
      |> Repo.all()
      |> Repo.preload([:operator, :location])
      |> Enum.map(&format_reading/1)

    json(conn, readings)
  end

  defp format_reading(reading) do
    %{
      id: reading.id,
      sensor_id: reading.sensor_id,
      timestamp: reading.timestamp,
      temperature: reading.temperature,
      voltage: reading.voltage,
      is_active: reading.is_active,
      operator: reading.operator.name,
      location: reading.location.name,
      inserted_at: reading.inserted_at,
      updated_at: reading.updated_at
    }
  end
end
