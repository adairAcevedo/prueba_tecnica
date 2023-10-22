defmodule DashboardWeb.TokenLiveTest do
  use DashboardWeb.ConnCase

  import Phoenix.LiveViewTest
  import Dashboard.MethodsFixtures

  @create_attrs %{last_hour_count: 42, token: "some token"}
  @update_attrs %{last_hour_count: 43, token: "some updated token"}
  @invalid_attrs %{last_hour_count: nil, token: nil}

  defp create_token(_) do
    token = token_fixture()
    %{token: token}
  end

  describe "Index" do
    setup [:create_token]

    test "lists all tokens", %{conn: conn, token: token} do
      {:ok, _index_live, html} = live(conn, ~p"/tokens")

      assert html =~ "Listing Tokens"
      assert html =~ token.token
    end

    test "saves new token", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tokens")

      assert index_live |> element("a", "New Token") |> render_click() =~
               "New Token"

      assert_patch(index_live, ~p"/tokens/new")

      assert index_live
             |> form("#token-form", token: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#token-form", token: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tokens")

      html = render(index_live)
      assert html =~ "Token created successfully"
      assert html =~ "some token"
    end

    test "updates token in listing", %{conn: conn, token: token} do
      {:ok, index_live, _html} = live(conn, ~p"/tokens")

      assert index_live |> element("#tokens-#{token.id} a", "Edit") |> render_click() =~
               "Edit Token"

      assert_patch(index_live, ~p"/tokens/#{token}/edit")

      assert index_live
             |> form("#token-form", token: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#token-form", token: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tokens")

      html = render(index_live)
      assert html =~ "Token updated successfully"
      assert html =~ "some updated token"
    end

    test "deletes token in listing", %{conn: conn, token: token} do
      {:ok, index_live, _html} = live(conn, ~p"/tokens")

      assert index_live |> element("#tokens-#{token.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tokens-#{token.id}")
    end
  end

  describe "Show" do
    setup [:create_token]

    test "displays token", %{conn: conn, token: token} do
      {:ok, _show_live, html} = live(conn, ~p"/tokens/#{token}")

      assert html =~ "Show Token"
      assert html =~ token.token
    end

    test "updates token within modal", %{conn: conn, token: token} do
      {:ok, show_live, _html} = live(conn, ~p"/tokens/#{token}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Token"

      assert_patch(show_live, ~p"/tokens/#{token}/show/edit")

      assert show_live
             |> form("#token-form", token: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#token-form", token: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tokens/#{token}")

      html = render(show_live)
      assert html =~ "Token updated successfully"
      assert html =~ "some updated token"
    end
  end
end
