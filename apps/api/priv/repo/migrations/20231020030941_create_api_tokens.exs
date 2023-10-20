defmodule Api.Repo.Migrations.CreateApiTokens do
  use Ecto.Migration

  def up do
    create table(:api_tokens) do
      add :token, :string
      add :last_hour_count, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
