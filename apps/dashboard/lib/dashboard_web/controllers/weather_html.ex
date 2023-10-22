defmodule DashboardWeb.WeatherHTML do
  use DashboardWeb, :html

  embed_templates "weather_html/*"

  @doc """
  Renders a weather form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def weather_form(assigns)
end
