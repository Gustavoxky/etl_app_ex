defmodule EtlWeb.Data.Operator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "operators" do
    field(:name, :string)
    timestamps()
  end

  def changeset(operator, attrs) do
    operator
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
