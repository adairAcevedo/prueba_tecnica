defmodule Dashboard.Methods.ChuckNorrisApi do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chuck_norris_api" do
    field :url, :string
    field :created_at, :string, virtual: true
    field :external_id, :string, virtual: true
    field :value, :string, virtual: true
    field :updated_at, :string, virtual: true
    field :categories, {:array, :string}
    field :icon_url, :string, virtual: true
  end

  @doc false
  def changeset(chuck_norris_api, attrs) do
    chuck_norris_api
    |> cast(attrs, [:url,:created_at,:external_id,:value,:updated_at,:categories, :icon_url])
    |> validate_required([:url])
  end
end
