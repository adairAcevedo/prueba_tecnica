defmodule Api.Accounts.HistoryApiToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "history_api_tokens" do
    field :time_request, :naive_datetime
    # field :api_token_id, :id
    belongs_to :api_token, Api.Accounts.ApiToken

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(history_api_token, attrs) do
    history_api_token
    |> cast(attrs, [:api_token_id, :time_request])
    |> validate_required([:api_token_id, :time_request])
  end
end
