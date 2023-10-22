defmodule DashboardWeb.CompoundInterestControllerTest do
  use DashboardWeb.ConnCase

  import Dashboard.MethodsFixtures

  @create_attrs %{anual_rate: 120.5, periods: 42, principal_amount: 42}
  @update_attrs %{anual_rate: 456.7, periods: 43, principal_amount: 43}
  @invalid_attrs %{anual_rate: nil, periods: nil, principal_amount: nil}

  describe "index" do
    test "lists all compound_interests", %{conn: conn} do
      conn = get(conn, ~p"/compound_interests")
      assert html_response(conn, 200) =~ "Listing Compound interests"
    end
  end

  describe "new compound_interest" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/compound_interests/new")
      assert html_response(conn, 200) =~ "New Compound interest"
    end
  end

  describe "create compound_interest" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/compound_interests", compound_interest: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/compound_interests/#{id}"

      conn = get(conn, ~p"/compound_interests/#{id}")
      assert html_response(conn, 200) =~ "Compound interest #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/compound_interests", compound_interest: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Compound interest"
    end
  end

  describe "edit compound_interest" do
    setup [:create_compound_interest]

    test "renders form for editing chosen compound_interest", %{conn: conn, compound_interest: compound_interest} do
      conn = get(conn, ~p"/compound_interests/#{compound_interest}/edit")
      assert html_response(conn, 200) =~ "Edit Compound interest"
    end
  end

  describe "update compound_interest" do
    setup [:create_compound_interest]

    test "redirects when data is valid", %{conn: conn, compound_interest: compound_interest} do
      conn = put(conn, ~p"/compound_interests/#{compound_interest}", compound_interest: @update_attrs)
      assert redirected_to(conn) == ~p"/compound_interests/#{compound_interest}"

      conn = get(conn, ~p"/compound_interests/#{compound_interest}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, compound_interest: compound_interest} do
      conn = put(conn, ~p"/compound_interests/#{compound_interest}", compound_interest: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Compound interest"
    end
  end

  describe "delete compound_interest" do
    setup [:create_compound_interest]

    test "deletes chosen compound_interest", %{conn: conn, compound_interest: compound_interest} do
      conn = delete(conn, ~p"/compound_interests/#{compound_interest}")
      assert redirected_to(conn) == ~p"/compound_interests"

      assert_error_sent 404, fn ->
        get(conn, ~p"/compound_interests/#{compound_interest}")
      end
    end
  end

  defp create_compound_interest(_) do
    compound_interest = compound_interest_fixture()
    %{compound_interest: compound_interest}
  end
end
