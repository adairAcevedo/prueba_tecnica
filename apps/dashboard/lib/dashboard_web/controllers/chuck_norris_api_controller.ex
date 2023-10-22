defmodule DashboardWeb.ChuckNorrisApiController do
  use DashboardWeb, :controller

  alias Dashboard.Methods
  alias Dashboard.Methods.ChuckNorrisApi

  def index(conn, _params) do
    changeset = Methods.change_chuck_norris_api(%ChuckNorrisApi{})
    conn
    |> assign(:changeset, changeset)
    |> assign(:errors, "")
    |> render(:index, chuck_norris_api: %{})
  end

  def post_api(conn, %{"chuck_norris_api" => %{"url" => url} = chuck_norris_api_params}) do

    headers = ["X-API-TOKEN": "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy", "Accept": "Application/json; Charset=utf-8"]
    DahsboardWeb.HTTP.get("#{url}", headers)
    |> case do
      {:ok, response} ->
        response |> IO.inspect()
        changeset = Methods.change_chuck_norris_api(%ChuckNorrisApi{}, chuck_norris_api_params)
        response_decode = response |> Jason.decode!
        chuck_norris_api = Methods.change_chuck_norris_api(changeset |> Ecto.Changeset.apply_changes, response_decode |> Map.put("external_id", response_decode["id"] )) |> Ecto.Changeset.apply_changes
        |> IO.inspect()
        conn
          |> assign(:chuck_norris_api, chuck_norris_api)
          |> assign(:errors, "")
          |> assign(:changeset, changeset)
          |> render(:index)
      {:error, errors} ->
        changeset = Methods.change_chuck_norris_api(%ChuckNorrisApi{}, chuck_norris_api_params)
        conn
          |> assign(:chuck_norris_api, %{})
          |> assign(:changeset, changeset)
          |> assign(:errors, Map.get(errors, "error", ""))
          |> render(:index)
      end
  end

  # def new(conn, _params) do
  #   changeset = Methods.change_chuck_norris_api(%ChuckNorrisApi{})
  #   render(conn, :new, changeset: changeset)
  # end

  # def create(conn, %{"chuck_norris_api" => chuck_norris_api_params}) do
  #   case Methods.create_chuck_norris_api(chuck_norris_api_params) do
  #     {:ok, chuck_norris_api} ->
  #       conn
  #       |> put_flash(:info, "Chuck norris api created successfully.")
  #       |> redirect(to: ~p"/chuck_norris_api/#{chuck_norris_api}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :new, changeset: changeset)
  #   end
  # end

  # def create(conn, %{"chuck_norris_api" => chuck_norris_api_params}) do
  #   case Methods.create_chuck_norris_api(chuck_norris_api_params) do
  #     {:ok, chuck_norris_api} ->
  #       conn
  #       |> put_flash(:info, "Chuck norris api created successfully.")
  #       |> redirect(to: ~p"/chuck_norris_api/#{chuck_norris_api}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :new, changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   chuck_norris_api = Methods.get_chuck_norris_api!(id)
  #   render(conn, :show, chuck_norris_api: chuck_norris_api)
  # end

  # def edit(conn, %{"id" => id}) do
  #   chuck_norris_api = Methods.get_chuck_norris_api!(id)
  #   changeset = Methods.change_chuck_norris_api(chuck_norris_api)
  #   render(conn, :edit, chuck_norris_api: chuck_norris_api, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "chuck_norris_api" => chuck_norris_api_params}) do
  #   chuck_norris_api = Methods.get_chuck_norris_api!(id)

  #   case Methods.update_chuck_norris_api(chuck_norris_api, chuck_norris_api_params) do
  #     {:ok, chuck_norris_api} ->
  #       conn
  #       |> put_flash(:info, "Chuck norris api updated successfully.")
  #       |> redirect(to: ~p"/chuck_norris_api/#{chuck_norris_api}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :edit, chuck_norris_api: chuck_norris_api, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   chuck_norris_api = Methods.get_chuck_norris_api!(id)
  #   {:ok, _chuck_norris_api} = Methods.delete_chuck_norris_api(chuck_norris_api)

  #   conn
  #   |> put_flash(:info, "Chuck norris api deleted successfully.")
  #   |> redirect(to: ~p"/chuck_norris_api")
  # end
end
