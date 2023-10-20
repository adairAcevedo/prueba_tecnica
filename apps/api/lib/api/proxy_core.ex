defmodule Api.ProxyCore do
  @base_url "https://api.chucknorris.io/jokes/"
  def get_joker_resp(name) when is_binary(name) do
    name
    |> poison_get
  end

  def get_joker_resp(_), do: %{error: "valor vacio"}

  defp poison_get(name) do
    case HTTPoison.get "#{@base_url}#{name}" do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{ok: body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        %{error: "valor no encontrado"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        %{error: reason}
    end
  end
end
