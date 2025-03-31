defmodule EtlApp.ETL.Importer do
  def run(path \\ "data/input.csv", _source \\ "manual") do
    try do
      rows =
        path
        |> File.stream!()
        |> CSV.decode!(headers: true)
        |> Enum.to_list()

      {:ok, rows}
    rescue
      e -> {:error, e}
    end
  end
end
