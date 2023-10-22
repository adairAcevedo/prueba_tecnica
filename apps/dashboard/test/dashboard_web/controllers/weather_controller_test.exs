defmodule DashboardWeb.WeatherControllerTest do
  use DashboardWeb.ConnCase

  import Dashboard.MethodsFixtures

  @create_attrs %{city: "some city"}
  @update_attrs %{city: "some updated city"}
  @invalid_attrs %{city: nil}

  describe "index" do
    test "lists all weathers", %{conn: conn} do
      conn = get(conn, ~p"/weathers")
      assert html_response(conn, 200) =~ "Listing Weathers"
    end
  end

  describe "new weather" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/weathers/new")
      assert html_response(conn, 200) =~ "New Weather"
    end
  end

  describe "create weather" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/weathers", weather: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/weathers/#{id}"

      conn = get(conn, ~p"/weathers/#{id}")
      assert html_response(conn, 200) =~ "Weather #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/weathers", weather: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Weather"
    end
  end

  describe "edit weather" do
    setup [:create_weather]

    test "renders form for editing chosen weather", %{conn: conn, weather: weather} do
      conn = get(conn, ~p"/weathers/#{weather}/edit")
      assert html_response(conn, 200) =~ "Edit Weather"
    end
  end

  describe "update weather" do
    setup [:create_weather]

    test "redirects when data is valid", %{conn: conn, weather: weather} do
      conn = put(conn, ~p"/weathers/#{weather}", weather: @update_attrs)
      assert redirected_to(conn) == ~p"/weathers/#{weather}"

      conn = get(conn, ~p"/weathers/#{weather}")
      assert html_response(conn, 200) =~ "some updated city"
    end

    test "renders errors when data is invalid", %{conn: conn, weather: weather} do
      conn = put(conn, ~p"/weathers/#{weather}", weather: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Weather"
    end
  end

  describe "delete weather" do
    setup [:create_weather]

    test "deletes chosen weather", %{conn: conn, weather: weather} do
      conn = delete(conn, ~p"/weathers/#{weather}")
      assert redirected_to(conn) == ~p"/weathers"

      assert_error_sent 404, fn ->
        get(conn, ~p"/weathers/#{weather}")
      end
    end
  end

  defp create_weather(_) do
    weather = weather_fixture()
    %{weather: weather}
  end
end
