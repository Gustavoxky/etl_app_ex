defmodule EtlWeb.Repo.Migrations.AddStatsToEtlRuns do
  use Ecto.Migration

  def change do
    alter table(:etl_runs) do
      add(:total_rows, :integer)
      add(:success_count, :integer)
      add(:error_count, :integer)
    end
  end
end
