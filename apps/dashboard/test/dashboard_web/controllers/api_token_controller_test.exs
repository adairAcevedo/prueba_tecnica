# defmodule DashboardWeb.ApiTokenControllerTest do
#   use DashboardWeb.ConnCase

#   import Dashboard.MethodsFixtures

#   @create_attrs %{last_hour_count: 42, token: "some token"}
#   @update_attrs %{last_hour_count: 43, token: "some updated token"}
#   @invalid_attrs %{last_hour_count: nil, token: nil}

#   describe "index" do
#     test "lists all api_tokens", %{conn: conn} do
#       conn = get(conn, ~p"/api_tokens")
#       assert html_response(conn, 200) =~ "Listing Api tokens"
#     end
#   end

#   describe "new api_token" do
#     test "renders form", %{conn: conn} do
#       conn = get(conn, ~p"/api_tokens/new")
#       assert html_response(conn, 200) =~ "New Api token"
#     end
#   end

#   describe "create api_token" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post(conn, ~p"/api_tokens", api_token: @create_attrs)

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == ~p"/api_tokens/#{id}"

#       conn = get(conn, ~p"/api_tokens/#{id}")
#       assert html_response(conn, 200) =~ "Api token #{id}"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, ~p"/api_tokens", api_token: @invalid_attrs)
#       assert html_response(conn, 200) =~ "New Api token"
#     end
#   end

#   describe "edit api_token" do
#     setup [:create_api_token]

#     test "renders form for editing chosen api_token", %{conn: conn, api_token: api_token} do
#       conn = get(conn, ~p"/api_tokens/#{api_token}/edit")
#       assert html_response(conn, 200) =~ "Edit Api token"
#     end
#   end

#   describe "update api_token" do
#     setup [:create_api_token]

#     test "redirects when data is valid", %{conn: conn, api_token: api_token} do
#       conn = put(conn, ~p"/api_tokens/#{api_token}", api_token: @update_attrs)
#       assert redirected_to(conn) == ~p"/api_tokens/#{api_token}"

#       conn = get(conn, ~p"/api_tokens/#{api_token}")
#       assert html_response(conn, 200) =~ "some updated token"
#     end

#     test "renders errors when data is invalid", %{conn: conn, api_token: api_token} do
#       conn = put(conn, ~p"/api_tokens/#{api_token}", api_token: @invalid_attrs)
#       assert html_response(conn, 200) =~ "Edit Api token"
#     end
#   end

#   describe "delete api_token" do
#     setup [:create_api_token]

#     test "deletes chosen api_token", %{conn: conn, api_token: api_token} do
#       conn = delete(conn, ~p"/api_tokens/#{api_token}")
#       assert redirected_to(conn) == ~p"/api_tokens"

#       assert_error_sent 404, fn ->
#         get(conn, ~p"/api_tokens/#{api_token}")
#       end
#     end
#   end

#   defp create_api_token(_) do
#     api_token = api_token_fixture()
#     %{api_token: api_token}
#   end
# end
