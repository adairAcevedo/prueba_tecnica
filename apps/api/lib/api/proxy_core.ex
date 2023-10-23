defmodule Api.ProxyCore do
  @joker_url "https://api.chucknorris.io/jokes/"
  @weather_url "https://api.openweathermap.org/data/2.5/weather"

  def get_joker_resp(name, query) when is_binary(name) and map_size(query) > 0 do

    url = URI.append_query(URI.parse("#{@joker_url}#{name}"), URI.encode_query(query)) |> URI.to_string()
    poison_get("#{url}")
  end
  def get_joker_resp(name, _query) when is_binary(name) do
    poison_get("#{@joker_url}#{name}")
  end

  def get_joker_resp(_), do: %{error: "valor vacio"}

  @spec get_weather(any()) :: %{optional(:error) => any(), optional(:ok) => any()}
  def get_weather(city_name) do
    poison_get("#{@weather_url}?q=#{city_name}&appid=#{System.get_env("WEATHER_API_TOKEN")}&units=metric&lang=es")
  end

  defp poison_get(url) do
    case HTTPoison.get url do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{ok: body}
      {:ok, %HTTPoison.Response{status_code: 401, body: _body}} ->
        %{ok: %{error: "Api key invalida"} |> Jason.encode! }
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        %{error: "Valor no encontrado"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        %{error: reason}
      error ->
        %{error: "Error Interno"}
    end
  end

end
