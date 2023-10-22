defmodule Dashboard.Methods.Weather do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weathers" do
    field :city, :string
    field :conditions, :string, virtual: true
    field :current_temp, :float, virtual: true
  end

  @doc false
  def changeset(weather, attrs) do
    weather
    |> cast(attrs, [:city, :conditions, :current_temp])
    |> validate_required([:city])
  end
end
