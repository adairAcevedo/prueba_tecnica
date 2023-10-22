defmodule Dashboard.Methods.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :last_hour_count, :integer
    field :token, :string
    field :user_id, :integer
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:token, :last_hour_count, :user_id])
    |> validate_required([:token])
  end
end
