defmodule ApiWeb.ProxyController do
  use ApiWeb, :controller


  def get_joker_data(conn, %{"name" => name} = params) do
    Api.ProxyCore.get_joker_resp(name, Map.delete(params, "name"))
      |> case do
        %{ok: response } ->
          conn
          |> put_view(json: ApiWeb.ProxyView)
          |> render("joker.json", response: response |>  Jason.decode!())
        %{error: error} ->
          conn
          |> put_view(json: ApiWeb.ProxyView)
          |> render("error.json", error: %{error: error})
      end

  end

  def calculate_compound_interest(conn, %{"principal" => principal, "tasa_anual" => anual_rate, "periodos" => periods} ) when is_integer(principal) and is_float(anual_rate) and is_integer(periods) do

    amount_total =  Api.Apicore.calculate_compound_interest(principal, anual_rate, periods)
    conn
      |> put_view(json: ApiWeb.ProxyView)
      |> render("compound_interest.json", response:
        %{
          amount_total: amount_total,
          request_detailed: %{
            principal: principal,
            tasa_anual: anual_rate,
            periodos: periods
          }
        }
      )
  end

  def calculate_compound_interest(conn, _args) do
    conn
      |> put_view(json: ApiWeb.ProxyView)
      |> render("error.json", error: %{error: "Asegurese de mandar los valores necesarios como el principal, anula_rate y periods y con su formato correcto"})
  end


  def get_wheather(conn, %{"city_name" => city_name}) when is_binary(city_name) do
    Api.ProxyCore.get_weather(city_name)
      |> case do
        %{ok: response } ->
          conn
          |> put_view(json: ApiWeb.ProxyView)
          |> render("wheather.json", response: response |>  Jason.decode!())
        %{error: error} ->
          conn
          |> put_view(json: ApiWeb.ProxyView)
          |> render("error.json", error: %{error: error})
      end
  end

  def get_wheather(conn, _args) do
    conn
      |> put_view(json: ApiWeb.ProxyView)
      |> render("error.json", error: %{error: "Asegurese de mandar el nombre de la ciudad"})
  end

end
