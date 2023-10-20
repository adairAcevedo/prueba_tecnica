defmodule ApiWeb.ProxyView do


  def render("joker.json", %{response: response}) do
    response
  end

  def render("error.json", %{error: error}) do
    error
  end

  def render("compound_interest.json", %{response: response}) do
    response
  end
end
