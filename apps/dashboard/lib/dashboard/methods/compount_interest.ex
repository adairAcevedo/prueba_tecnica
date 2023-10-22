defmodule Dashboard.Methods.CompoundInterest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api_tokens" do
    field :amount, :integer
    field :anual_rate, :float
    field :periods, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(api_token, attrs) do
    api_token
    |> cast(attrs, [:amount, :anual_rate, :periods])
    |> validate_required([:amount, :anual_rate, :periods])
  end
end
