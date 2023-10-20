defmodule Api.Repo.Migrations.CreateHistoryApiTokens do
  use Ecto.Migration

  def up do
    create table(:history_api_tokens) do
      add :api_token_id, references(:api_tokens), null: false
      add :time_request, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
