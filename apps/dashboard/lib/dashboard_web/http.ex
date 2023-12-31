defmodule DahsboardWeb.HTTP  do

  @base_url "#{System.get_env("API_HOST")}"
  def post(route, body, headers \\ [{"Content-Type", "application/json"}]) do
    case HTTPoison.post("#{@base_url}#{route}", body ,headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 401, body: body}} ->
        {:error, body |> Jason.decode!}
      {:ok, %HTTPoison.Response{status_code: 404, body: body}} ->
        {:error, body |> Jason.decode!}
      {:ok, %HTTPoison.Response{status_code: 403, body: body}} ->
        {:error, body |> Jason.decode!}
      {:ok, %HTTPoison.Response{status_code: 429, body: body}} ->
        {:error, body |> Jason.decode!}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
      error ->
        IO.inspect(error, label: "Error Interno 1")
        {:error, "Error Interno"}
    end
  end

  @spec get(any(), any(), any()) :: {:error, any()} | {:ok, any()}
  def get(route, headers, base_url \\ "#{System.get_env("API_HOST")}" ) do
    case HTTPoison.get("#{base_url}#{route}", headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 401, body: body}} ->
        {:error, body |> Jason.decode!}
      {:ok, %HTTPoison.Response{status_code: 404, body: body}} ->
        {:error, %{"error" => "Noy Found"}}
      {:ok, %HTTPoison.Response{status_code: 403, body: body}} ->
        {:error, body |> Jason.decode!}
      {:ok, %HTTPoison.Response{status_code: 429, body: body}} ->
        {:error, body |> Jason.decode!}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason |> Jason.decode!}
      error ->
          IO.inspect(error, label: "Error Interno")
        {:error, %{"error" => "Error Interno"}}
    end
  end

end
