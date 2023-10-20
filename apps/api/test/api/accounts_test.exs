defmodule Api.AccountsTest do
  use Api.DataCase

  alias Api.Accounts

  describe "api_tokens" do
    alias Api.Accounts.ApiToken

    import Api.AccountsFixtures

    @invalid_attrs %{last_hour_count: nil, token: nil}

    test "list_api_tokens/0 returns all api_tokens" do
      api_token = api_token_fixture()
      assert Accounts.list_api_tokens() == [api_token]
    end

    test "get_api_token!/1 returns the api_token with given id" do
      api_token = api_token_fixture()
      assert Accounts.get_api_token!(api_token.id) == api_token
    end

    test "create_api_token/1 with valid data creates a api_token" do
      valid_attrs = %{last_hour_count: 42, token: "some token"}

      assert {:ok, %ApiToken{} = api_token} = Accounts.create_api_token(valid_attrs)
      assert api_token.last_hour_count == 42
      assert api_token.token == "some token"
    end

    test "create_api_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_api_token(@invalid_attrs)
    end

    test "update_api_token/2 with valid data updates the api_token" do
      api_token = api_token_fixture()
      update_attrs = %{last_hour_count: 43, token: "some updated token"}

      assert {:ok, %ApiToken{} = api_token} = Accounts.update_api_token(api_token, update_attrs)
      assert api_token.last_hour_count == 43
      assert api_token.token == "some updated token"
    end

    test "update_api_token/2 with invalid data returns error changeset" do
      api_token = api_token_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_api_token(api_token, @invalid_attrs)
      assert api_token == Accounts.get_api_token!(api_token.id)
    end

    test "delete_api_token/1 deletes the api_token" do
      api_token = api_token_fixture()
      assert {:ok, %ApiToken{}} = Accounts.delete_api_token(api_token)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_api_token!(api_token.id) end
    end

    test "change_api_token/1 returns a api_token changeset" do
      api_token = api_token_fixture()
      assert %Ecto.Changeset{} = Accounts.change_api_token(api_token)
    end
  end

  describe "history_api_tokens" do
    alias Api.Accounts.HistoryApiToken

    import Api.AccountsFixtures

    @invalid_attrs %{time_request: nil, token: nil}

    test "list_history_api_tokens/0 returns all history_api_tokens" do
      history_api_token = history_api_token_fixture()
      assert Accounts.list_history_api_tokens() == [history_api_token]
    end

    test "get_history_api_token!/1 returns the history_api_token with given id" do
      history_api_token = history_api_token_fixture()
      assert Accounts.get_history_api_token!(history_api_token.id) == history_api_token
    end

    test "create_history_api_token/1 with valid data creates a history_api_token" do
      valid_attrs = %{time_request: ~N[2023-10-19 03:10:00], token: "some token"}

      assert {:ok, %HistoryApiToken{} = history_api_token} = Accounts.create_history_api_token(valid_attrs)
      assert history_api_token.time_request == ~N[2023-10-19 03:10:00]
      assert history_api_token.token == "some token"
    end

    test "create_history_api_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_history_api_token(@invalid_attrs)
    end

    test "update_history_api_token/2 with valid data updates the history_api_token" do
      history_api_token = history_api_token_fixture()
      update_attrs = %{time_request: ~N[2023-10-20 03:10:00], token: "some updated token"}

      assert {:ok, %HistoryApiToken{} = history_api_token} = Accounts.update_history_api_token(history_api_token, update_attrs)
      assert history_api_token.time_request == ~N[2023-10-20 03:10:00]
      assert history_api_token.token == "some updated token"
    end

    test "update_history_api_token/2 with invalid data returns error changeset" do
      history_api_token = history_api_token_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_history_api_token(history_api_token, @invalid_attrs)
      assert history_api_token == Accounts.get_history_api_token!(history_api_token.id)
    end

    test "delete_history_api_token/1 deletes the history_api_token" do
      history_api_token = history_api_token_fixture()
      assert {:ok, %HistoryApiToken{}} = Accounts.delete_history_api_token(history_api_token)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_history_api_token!(history_api_token.id) end
    end

    test "change_history_api_token/1 returns a history_api_token changeset" do
      history_api_token = history_api_token_fixture()
      assert %Ecto.Changeset{} = Accounts.change_history_api_token(history_api_token)
    end
  end
end
