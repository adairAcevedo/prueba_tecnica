defmodule DashboardWeb.ChuckNorrisApiControllerTest do
  use DashboardWeb.ConnCase

  import Dashboard.MethodsFixtures

  @create_attrs %{url: "some url"}
  @update_attrs %{url: "some updated url"}
  @invalid_attrs %{url: nil}

  describe "index" do
    test "lists all chuck_norris_api", %{conn: conn} do
      conn = get(conn, ~p"/chuck_norris_api")
      assert html_response(conn, 200) =~ "Listing Chuck norris api"
    end
  end

  describe "new chuck_norris_api" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/chuck_norris_api/new")
      assert html_response(conn, 200) =~ "New Chuck norris api"
    end
  end

  describe "create chuck_norris_api" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/chuck_norris_api", chuck_norris_api: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/chuck_norris_api/#{id}"

      conn = get(conn, ~p"/chuck_norris_api/#{id}")
      assert html_response(conn, 200) =~ "Chuck norris api #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/chuck_norris_api", chuck_norris_api: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Chuck norris api"
    end
  end

  describe "edit chuck_norris_api" do
    setup [:create_chuck_norris_api]

    test "renders form for editing chosen chuck_norris_api", %{conn: conn, chuck_norris_api: chuck_norris_api} do
      conn = get(conn, ~p"/chuck_norris_api/#{chuck_norris_api}/edit")
      assert html_response(conn, 200) =~ "Edit Chuck norris api"
    end
  end

  describe "update chuck_norris_api" do
    setup [:create_chuck_norris_api]

    test "redirects when data is valid", %{conn: conn, chuck_norris_api: chuck_norris_api} do
      conn = put(conn, ~p"/chuck_norris_api/#{chuck_norris_api}", chuck_norris_api: @update_attrs)
      assert redirected_to(conn) == ~p"/chuck_norris_api/#{chuck_norris_api}"

      conn = get(conn, ~p"/chuck_norris_api/#{chuck_norris_api}")
      assert html_response(conn, 200) =~ "some updated url"
    end

    test "renders errors when data is invalid", %{conn: conn, chuck_norris_api: chuck_norris_api} do
      conn = put(conn, ~p"/chuck_norris_api/#{chuck_norris_api}", chuck_norris_api: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Chuck norris api"
    end
  end

  describe "delete chuck_norris_api" do
    setup [:create_chuck_norris_api]

    test "deletes chosen chuck_norris_api", %{conn: conn, chuck_norris_api: chuck_norris_api} do
      conn = delete(conn, ~p"/chuck_norris_api/#{chuck_norris_api}")
      assert redirected_to(conn) == ~p"/chuck_norris_api"

      assert_error_sent 404, fn ->
        get(conn, ~p"/chuck_norris_api/#{chuck_norris_api}")
      end
    end
  end

  defp create_chuck_norris_api(_) do
    chuck_norris_api = chuck_norris_api_fixture()
    %{chuck_norris_api: chuck_norris_api}
  end
end
