defmodule Dashboard.Methods do
  @moduledoc """
  The Methods context.
  """
  import Ecto.Query, warn: false
  # alias Dashboard.Repo

  alias Dashboard.Methods.CompoundInterest

  alias Dashboard.Methods.Weather
  alias Dashboard.Methods.ChuckNorrisApi
  alias Dashboard.Methods.Token

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking compound_interest changes.

  ## Examples

      iex> change_compound_interest(compound_interest)
      %Ecto.Changeset{data: %CompoundInterest{}}

  """
  def change_compound_interest(%CompoundInterest{} = compound_interest, attrs \\ %{}) do
    CompoundInterest.changeset(compound_interest, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking token changes.

  ## Examples

      iex> change_token(token)
      %Ecto.Changeset{data: %Token{}}

  """

  def change_token(%Token{} = token, attrs \\ %{}) do
    Token.changeset(token, attrs)
  end

  def change_chuck_norris_api(%ChuckNorrisApi{} = chuck_norris_api, attrs \\ %{}) do
    ChuckNorrisApi.changeset(chuck_norris_api, attrs)
  end

  def change_weather(%Weather{} = weather, attrs \\ %{}) do
    Weather.changeset(weather, attrs)
  end

end
