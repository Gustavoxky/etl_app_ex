defmodule EtlWebWeb.EtlController do
  use EtlWebWeb, :controller

  alias EtlWeb.Repo
  alias EtlWeb.Data.{EtlRun, SensorReading, Operator, Location}
  alias EtlApp.ETL.Importer

  def run(conn, _params) do
    case Importer.run("data/input.csv") do
      {:ok, rows} ->
        {success, error} =
          Enum.reduce(rows, {0, 0}, fn row, {ok, err} ->
            case insert_normalized(row) do
              :ok -> {ok + 1, err}
              :error -> {ok, err + 1}
            end
          end)

        %EtlRun{}
        |> EtlRun.changeset(%{
          source: "manual",
          status: "ok",
          message: "ETL finalizado",
          file_path: "data/input.csv",
          total_rows: success + error,
          success_count: success,
          error_count: error
        })
        |> Repo.insert()

        json(conn, %{status: "ok", total: success + error, success: success, error: error})

      {:error, reason} ->
        %EtlRun{}
        |> EtlRun.changeset(%{
          source: "manual",
          status: "error",
          message: Exception.message(reason),
          file_path: "data/input.csv"
        })
        |> Repo.insert()

        conn
        |> put_status(500)
        |> json(%{error: "Erro ao executar ETL", reason: Exception.message(reason)})
    end
  end

  defp insert_normalized(row) do
    try do
      operator = get_or_create_operator(row["operator"])
      location = get_or_create_location(row["location"])

      timestamp =
        case DateTime.from_iso8601(row["timestamp"]) do
          {:ok, dt, _} -> dt
          _ -> nil
        end

      attrs = %{
        sensor_id: String.to_integer(row["sensor_id"]),
        timestamp: timestamp,
        temperature: String.to_float(row["temperature"]),
        voltage: String.to_float(row["voltage"]),
        is_active: row["is_active"] == "true",
        operator_id: operator.id,
        location_id: location.id
      }

      %SensorReading{}
      |> SensorReading.changeset(attrs)
      |> Repo.insert()

      :ok
    rescue
      _ -> :error
    end
  end

  defp get_or_create_operator(name) do
    Repo.get_by(Operator, name: name) ||
      %Operator{} |> Operator.changeset(%{name: name}) |> Repo.insert!()
  end

  defp get_or_create_location(name) do
    Repo.get_by(Location, name: name) ||
      %Location{} |> Location.changeset(%{name: name}) |> Repo.insert!()
  end
end
