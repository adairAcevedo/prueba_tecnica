defmodule ApiWeb.Plugs.GetAuthToken do
  def init(opts), do: opts

  def call(conn, _opts) do
    case get_token(conn) do
      {:ok, current_token} ->
        conn
      {:error, error} ->
        conn
        |> Phoenix.Controller.put_view(json: ApiWeb.ProxyView)
        |> Phoenix.Controller.render("error.json", error: %{error: error})
        |> Plug.Conn.halt()
    end
  end

  def get_token(conn) do
    conn.req_headers
      |> Enum.filter(fn({name, _}) -> name == "x-api-token" end)
      |> List.first
      |>  case  do
            nil -> {:error, %{error: "El token no esta establecido en los headers"}}
            {_, token} -> valid_token(token)
          end
  end

  def valid_token(token) do
    case Api.Accounts.get_api_token_by_token(token) do
      {:ok, api_token} ->
        verify_limit_token(api_token)
      _ ->
        {:error, %{error: "Token invalido"}}
    end
  end


  def verify_limit_token(api_token) do
    Api.Accounts.last_hour_token_count(api_token)
    |> case do
      nil -> {:error, %{error: "Ocurrio un error al validar tu token"}}
      false -> {:error,  %{error: "Demasiadas solicitudes. Por favor, espere y vuelva a intentarlo más tarde."}}
      token_count -> {:ok, Api.Accounts.update_api_token_with_history_token(api_token, token_count)}
    end
  end
end
