defmodule EtlWebWeb.UploadController do
  use EtlWebWeb, :controller

  def upload_csv(conn, %{"file" => %Plug.Upload{path: temp_path}}) do
    # Passa o caminho para o ETL
    case EtlApp.ETL.Importer.run(temp_path) do
      :ok ->
        json(conn, %{status: "CSV processado com sucesso"})

      {:error, reason} ->
        conn
        |> put_status(500)
        |> json(%{error: "Erro ao processar CSV", reason: inspect(reason)})
    end
  end

  def upload_csv(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{error: "Arquivo CSV não enviado"})
  end
end
