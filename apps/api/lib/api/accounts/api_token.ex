defmodule Api.Accounts.ApiToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api_tokens" do
    field :last_hour_count, :integer
    field :token, :string
    has_many :history_api_tokens, Api.Accounts.HistoryApiToken

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(api_token, attrs) do
    api_token
    |> cast(attrs, [:token, :last_hour_count])
    |> validate_required([:token, :last_hour_count])
  end

  def changeset_update(api_token, attrs) do
    api_token
    |> cast(attrs, [:last_hour_count])
    |> validate_required([:last_hour_count])
  end
end
