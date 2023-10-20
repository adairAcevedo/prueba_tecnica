defmodule ApiWeb.ProxyController do
  use ApiWeb, :controller


  def get_joker_data(conn, %{"name" => name}) do

    ApiWeb.ProxyCore.get_joker_resp(name)
      |> case do
        %{ok: response } ->
          conn
          |> put_view(json: ApiWeb.ProxyView)
          |> render("joker.json", response: response |>  Jason.decode!())
          # render(conn, "joker.json", response: response)
        %{error: error} ->
          conn
          |> put_view(json: ApiWeb.ProxyView)
          |> render("error.json", error: %{error: error})
          # render(conn, "error.json", error: %{error: error})
      end

  end



end
