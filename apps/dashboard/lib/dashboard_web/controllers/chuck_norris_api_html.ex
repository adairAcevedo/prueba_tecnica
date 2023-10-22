defmodule DashboardWeb.ChuckNorrisApiHTML do
  use DashboardWeb, :html

  embed_templates "chuck_norris_api_html/*"

  @doc """
  Renders a chuck_norris_api form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def chuck_norris_api_form(assigns)
end
