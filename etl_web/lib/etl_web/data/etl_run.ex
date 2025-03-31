defmodule EtlWeb.Data.EtlRun do
  use Ecto.Schema
  import Ecto.Changeset

  schema "etl_runs" do
    field(:source, :string)
    field(:status, :string)
    field(:message, :string)
    field(:file_path, :string)
    field(:total_rows, :integer)
    field(:success_count, :integer)
    field(:error_count, :integer)

    timestamps()
  end

  def changeset(run, attrs) do
    run
    |> cast(attrs, [
      :source,
      :status,
      :message,
      :file_path,
      :total_rows,
      :success_count,
      :error_count
    ])
    |> validate_required([:source, :status])
  end
end
