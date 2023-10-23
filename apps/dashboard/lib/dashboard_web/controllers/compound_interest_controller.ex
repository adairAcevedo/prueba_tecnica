defmodule DashboardWeb.CompoundInterestController do
  use DashboardWeb, :controller

  alias Dashboard.Methods
  alias Dashboard.Methods.CompoundInterest

  def index(conn, _params) do
    changeset = Methods.change_compound_interest(%CompoundInterest{})
    conn
    |> assign(:changeset, changeset)
    |> assign(:errors, "")
    |> render(:index, compound_interest: %{})
  end

  def post_calculate(conn, %{"compound_interest" => compound_interest_params}) do
    headers = ["X-API-TOKEN": "#{System.get_env("API_TOKEN", "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy")}", "Accept": "Application/json; Charset=utf-8", "Content-Type": "application/json"]

    changeset = Methods.change_compound_interest(%CompoundInterest{}, compound_interest_params)
    |> Ecto.Changeset.apply_changes

    data_encode =  %{"periodos" => changeset.periods, "principal" => changeset.principal_amount, "tasa_anual" => changeset.anual_rate}
      |> Jason.encode!
    DahsboardWeb.HTTP.post("/calcular-intereses", data_encode ,headers)
    |> case do
      {:ok, response} ->
        conn
          |> assign(:changeset, Methods.change_compound_interest(%CompoundInterest{}, compound_interest_params))
          |> assign(:compound_interest, response |> Jason.decode!)
          |> assign(:errors, "")
          |> render(:index)
      {:error, errors} ->
        conn
          |> assign(:changeset, Methods.change_compound_interest(%CompoundInterest{}, compound_interest_params))
          |> assign(:compound_interest, %{})
          |> assign(:errors, Map.get(errors, "error", ""))
          |> render(:index)
    end

  end

end
