defmodule DashboardWeb.ChuckNorrisApiController do
  use DashboardWeb, :controller

  alias Dashboard.Methods
  alias Dashboard.Methods.ChuckNorrisApi

  def index(conn, _params) do
    changeset = Methods.change_chuck_norris_api(%ChuckNorrisApi{})
    conn
    |> assign(:changeset, changeset)
    |> assign(:errors, "")
    |> assign(:response, "")
    |> assign(:response_decode, %{})
    |> render(:index, chuck_norris_api: %{})
  end

  def post_api(conn, %{"chuck_norris_api" => %{"url" => url} = chuck_norris_api_params}) do

    headers = ["X-API-TOKEN": "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy", "Accept": "Application/json; Charset=utf-8"]
    DahsboardWeb.HTTP.get("#{url}", headers)
    |> case do
      {:ok, response} ->
        changeset = Methods.change_chuck_norris_api(%ChuckNorrisApi{}, chuck_norris_api_params)
        response_decode = response |> Jason.decode!
        conn
          |> assign(:chuck_norris_api, %{})
          |> assign(:errors, "")
          |> assign(:response, response )
          |> assign(:response_decode, response_decode)
          |> assign(:changeset, changeset)
          |> render(:index)
      {:error, errors} ->
        changeset = Methods.change_chuck_norris_api(%ChuckNorrisApi{}, chuck_norris_api_params)
        conn
          |> assign(:chuck_norris_api, %{})
          |> assign(:changeset, changeset)
          |> assign(:response, "")
          |> assign(:response_decode, %{})
          |> assign(:errors, Map.get(errors, "error", ""))
          |> render(:index)
      end
  end


end
