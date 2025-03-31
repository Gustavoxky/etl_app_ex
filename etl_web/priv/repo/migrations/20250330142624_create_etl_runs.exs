defmodule EtlWeb.Repo.Migrations.CreateEtlRuns do
  use Ecto.Migration

  def change do
    create table(:etl_runs) do
      add(:source, :string)
      add(:status, :string)
      add(:message, :text)
      add(:file_path, :string)

      timestamps()
    end
  end
end
