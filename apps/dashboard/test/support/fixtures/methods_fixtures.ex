defmodule Dashboard.MethodsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dashboard.Methods` context.
  """

  @doc """
  Generate a compound_interest.
  """
  def compound_interest_fixture(attrs \\ %{}) do
    {:ok, compound_interest} =
      attrs
      |> Enum.into(%{
        anual_rate: 120.5,
        periods: 42,
        principal_amount: 42
      })
      |> Dashboard.Methods.create_compound_interest()

    compound_interest
  end
end
