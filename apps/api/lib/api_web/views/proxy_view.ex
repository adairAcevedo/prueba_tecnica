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

  def render("wheather.json", %{response: response}) do
    weather_description = case response["weather"] do
      [] -> ""
      _ -> response["weather"] |> List.first |> Map.get("description")
    end

    %{
      "conditions" => weather_description,
      "current_temp" => response["main"]["temp"],
      "city" => response["name"]
    }
  end
end
