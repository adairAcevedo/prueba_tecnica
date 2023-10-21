defmodule ApiWeb.ApiTokenController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.ApiToken

  def index(conn, _params) do
    api_tokens = Accounts.list_api_tokens()
    conn
      |> put_view(json: ApiWeb.ApiTokenView)
      |> render("api_tokens.json", response: api_tokens )
  end

  def new(conn, _params) do
    case Accounts.create_new_api_token() do
      {:ok, api_token} ->
        conn
        |> put_view(json: ApiWeb.ApiTokenView)
        |> render("api_token.json", response: api_token )

      {:error, error} ->
        conn
          |> put_view(json: ApiWeb.ApiTokenView)
          |> render("error.json", response: error )
    end
  end

end
