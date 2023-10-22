defmodule DashboardWeb.WeatherController do
  use DashboardWeb, :controller

  alias Dashboard.Methods
  alias Dashboard.Methods.Weather

  def index(conn, %{"city_name" => city_name} = _params) do
    changeset = Methods.change_weather(%Weather{}, %{"city" => city_name})
    conn
    |> assign(:changeset, changeset)
    |> assign(:errors, "")
    |> get_weather( city_name)
    |> render(:index)
  end

  def index(conn, _params) do
    changeset = Methods.change_weather(%Weather{})
    render(conn, :index, weather: %{}, changeset: changeset, errors: "")
  end

  def post_weather(conn, %{"weather" => %{"city" => city_name}}) do
    conn
      |> redirect(to: ~p"/weathers?city_name=#{city_name}")
  end

  defp get_weather(conn, city_name) do

    headers = ["X-API-TOKEN": "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy", "Accept": "Application/json; Charset=utf-8"]
    DahsboardWeb.HTTP.get("/weather/#{city_name}", headers)
    |> case do
      {:ok, response} ->
        weather = Methods.change_weather(conn.assigns.changeset |> Ecto.Changeset.apply_changes , response |> Jason.decode!) |> Ecto.Changeset.apply_changes
        conn
          |> assign(:weather, weather)
          |> assign(:errors, "")
      {:error, errors} ->
        conn
          |> assign(:weather, %{})
          |> assign(:errors, Map.get(errors, "error", ""))
    end
  end

end
