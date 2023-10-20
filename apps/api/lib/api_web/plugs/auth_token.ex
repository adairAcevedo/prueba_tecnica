defmodule ApiWeb.Plugs.GetAuthToken do
  def init(opts), do: opts

  def call(conn, _opts) do
    case get_token(conn) do
      {:ok, current_token} ->
        IO.inspect(current_token, label: "este es token actual")
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
            {_, token} -> {:ok, token}
          end
  end

  def valid_token() do

  end


  def limit_token() do # falta limitar el token y que este sea valido ya sea con un cahce o con una db
    # crear cache
    # registrar todas las peticiones con fecha utc
    # hacer un count de las peticiones cada vez que se realiza una y almacenarlas en una key
    #
  end
end
