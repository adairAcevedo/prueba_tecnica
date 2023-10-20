defmodule Api.Accounts do
  @limit_token_use_by_hour 20
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo
  alias Ecto.Multi

  alias Api.Accounts.ApiToken

  @doc """
  Returns the list of api_tokens.

  ## Examples

      iex> list_api_tokens()
      [%ApiToken{}, ...]

  """
  def list_api_tokens do
    Repo.all(ApiToken)
  end

  @doc """
  Gets a single api_token.

  Raises `Ecto.NoResultsError` if the Api token does not exist.

  ## Examples

      iex> get_api_token!(123)
      %ApiToken{}

      iex> get_api_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_token!(id), do: Repo.get!(ApiToken, id)

  # Repo.get!(ApiToken, id)

  @doc """
  Creates a api_token.

  ## Examples

      iex> create_api_token(%{field: value})
      {:ok, %ApiToken{}}

      iex> create_api_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_token(attrs \\ %{}) do
    %ApiToken{}
    |> ApiToken.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api_token.

  ## Examples

      iex> update_api_token(api_token, %{field: new_value})
      {:ok, %ApiToken{}}

      iex> update_api_token(api_token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_token(%ApiToken{} = api_token, attrs) do
    api_token
    |> ApiToken.changeset_update(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a api_token.

  ## Examples

      iex> delete_api_token(api_token)
      {:ok, %ApiToken{}}

      iex> delete_api_token(api_token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_token(%ApiToken{} = api_token) do
    Repo.delete(api_token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api_token changes.

  ## Examples

      iex> change_api_token(api_token)
      %Ecto.Changeset{data: %ApiToken{}}

  """
  def change_api_token(%ApiToken{} = api_token, attrs \\ %{}) do
    ApiToken.changeset(api_token, attrs)
  end

  alias Api.Accounts.HistoryApiToken

  @doc """
  Returns the list of history_api_tokens.

  ## Examples

      iex> list_history_api_tokens()
      [%HistoryApiToken{}, ...]

  """
  def list_history_api_tokens do
    Repo.all(HistoryApiToken)
  end

  @doc """
  Gets a single history_api_token.

  Raises `Ecto.NoResultsError` if the History api token does not exist.

  ## Examples

      iex> get_history_api_token!(123)
      %HistoryApiToken{}

      iex> get_history_api_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_history_api_token!(id), do: Repo.get!(HistoryApiToken, id)

  @doc """
  Creates a history_api_token.

  ## Examples

      iex> create_history_api_token(%{field: value})
      {:ok, %HistoryApiToken{}}

      iex> create_history_api_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_history_api_token(attrs \\ %{}) do
    %HistoryApiToken{}
    |> HistoryApiToken.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a history_api_token.

  ## Examples

      iex> update_history_api_token(history_api_token, %{field: new_value})
      {:ok, %HistoryApiToken{}}

      iex> update_history_api_token(history_api_token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_history_api_token(%HistoryApiToken{} = history_api_token, attrs) do
    history_api_token
    |> HistoryApiToken.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a history_api_token.

  ## Examples

      iex> delete_history_api_token(history_api_token)
      {:ok, %HistoryApiToken{}}

      iex> delete_history_api_token(history_api_token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_history_api_token(%HistoryApiToken{} = history_api_token) do
    Repo.delete(history_api_token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking history_api_token changes.

  ## Examples

      iex> change_history_api_token(history_api_token)
      %Ecto.Changeset{data: %HistoryApiToken{}}

  """
  def change_history_api_token(%HistoryApiToken{} = history_api_token, attrs \\ %{}) do
    HistoryApiToken.changeset(history_api_token, attrs)
  end

  def get_api_token_by_token(token) do
    Repo.get_by(ApiToken, token: token) |> Repo.preload([:history_api_tokens])
    |> case do
      nil -> {:error, %{error: "Api token not valid"}}
      api_token -> {:ok, api_token}
    end
  end


  def last_hour_token_count(%ApiToken{}= api_token) do
    time_now = Timex.now
    token_count = api_token.history_api_tokens
      |> Enum.filter(fn history_api_token ->
        Timex.diff(time_now, history_api_token.time_request, :seconds) < 3600
      end)
      |> Enum.count()
    token_count < @limit_token_use_by_hour
  end

  def last_hour_token_count(_), do: nil

  def update_api_token_with_history_token(api_token,_current_token_count) do
    Api.Accounts.create_history_api_token(%{api_token_id: api_token.id, time_request: Timex.now })
    # Multi.new()
    #   |> Multi.update(:api_token, Api.Accounts.update_api_token(api_token, %{last_hour_count: current_token_count + 1}))
    #   |> Multi.insert(:history_token, Api.Accounts.create_history_api_token(%{api_token_id: api_token.id, time_request: Timex.now }))
    #   |> Repo.transaction()
  end
end
