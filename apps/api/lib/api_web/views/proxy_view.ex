defmodule ApiWeb.ProxyView do


  def render("joker.json", %{response: response}) do
    response
  end

  def render("error.json", %{error: error}) do
    error
  end
end
