defmodule DashboardWeb.TokenControllerTest do
  use DashboardWeb.ConnCase

  import Dashboard.MethodsFixtures

  @create_attrs %{last_hour_count: 42, token: "some token"}
  @update_attrs %{last_hour_count: 43, token: "some updated token"}
  @invalid_attrs %{last_hour_count: nil, token: nil}

  describe "index" do
    test "lists all tokens", %{conn: conn} do
      conn = get(conn, ~p"/tokens")
      assert html_response(conn, 200) =~ "Listing Tokens"
    end
  end

  describe "new token" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/tokens/new")
      assert html_response(conn, 200) =~ "New Token"
    end
  end

  describe "create token" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/tokens", token: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/tokens/#{id}"

      conn = get(conn, ~p"/tokens/#{id}")
      assert html_response(conn, 200) =~ "Token #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/tokens", token: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Token"
    end
  end

  describe "edit token" do
    setup [:create_token]

    test "renders form for editing chosen token", %{conn: conn, token: token} do
      conn = get(conn, ~p"/tokens/#{token}/edit")
      assert html_response(conn, 200) =~ "Edit Token"
    end
  end

  describe "update token" do
    setup [:create_token]

    test "redirects when data is valid", %{conn: conn, token: token} do
      conn = put(conn, ~p"/tokens/#{token}", token: @update_attrs)
      assert redirected_to(conn) == ~p"/tokens/#{token}"

      conn = get(conn, ~p"/tokens/#{token}")
      assert html_response(conn, 200) =~ "some updated token"
    end

    test "renders errors when data is invalid", %{conn: conn, token: token} do
      conn = put(conn, ~p"/tokens/#{token}", token: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Token"
    end
  end

  describe "delete token" do
    setup [:create_token]

    test "deletes chosen token", %{conn: conn, token: token} do
      conn = delete(conn, ~p"/tokens/#{token}")
      assert redirected_to(conn) == ~p"/tokens"

      assert_error_sent 404, fn ->
        get(conn, ~p"/tokens/#{token}")
      end
    end
  end

  defp create_token(_) do
    token = token_fixture()
    %{token: token}
  end
end
