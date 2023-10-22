defmodule DashboardWeb.CompoundInterestHTML do
  use DashboardWeb, :html

  embed_templates "compound_interest_html/*"

  @doc """
  Renders a compound_interest form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def compound_interest_form(assigns)

  def get_percentaje(value) when is_float(value) do
    "#{value * 100} %"
  end
  def get_percentaje(value), do: value
end
