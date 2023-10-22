defmodule Dashboard.Methods.CompoundInterest do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dashboard.Methods.RequestDetailed

  schema "compound_interests" do
    field :anual_rate, :float
    field :periods, :integer
    field :principal_amount, :integer
    field :amount_total,:float, virtual: true
    embeds_one :request_detailed, RequestDetailed
  end

  @doc false
  def changeset(compound_interest, attrs) do
    compound_interest
    |> cast(attrs, [:principal_amount, :anual_rate, :periods])
    |> cast_embed(:request_detailed)
    |> validate_required([:principal_amount, :anual_rate, :periods])
  end
end


defmodule Dashboard.Methods.RequestDetailed do
  use Ecto.Schema
  @derive Jason.Encoder
  import Ecto.Changeset
  @primary_key false
  embedded_schema do
    field :anual_rate, :float
    field :periods, :integer
    field :principal_amount, :integer
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:anual_rate, :periods, :principal_amount])
  end
end
