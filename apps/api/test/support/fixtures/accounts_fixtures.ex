defmodule Api.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Accounts` context.
  """

  @doc """
  Generate a api_token.
  """
  def api_token_fixture(attrs \\ %{}) do
    {:ok, api_token} =
      attrs
      |> Enum.into(%{
        last_hour_count: 42,
        token: "some token"
      })
      |> Api.Accounts.create_api_token()

    api_token
  end

  @doc """
  Generate a history_api_token.
  """
  def history_api_token_fixture(attrs \\ %{}) do
    {:ok, history_api_token} =
      attrs
      |> Enum.into(%{
        time_request: ~N[2023-10-19 03:10:00],
        token: "some token"
      })
      |> Api.Accounts.create_history_api_token()

    history_api_token
  end
end
