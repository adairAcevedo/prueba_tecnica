defmodule DashboardWeb.TokenLive.Index do
  use DashboardWeb, :live_view

  alias Dashboard.Methods
  alias Dashboard.Methods.Token

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :tokens, [])}
    # {:ok, socket |> get_token()}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Token")
    |> assign(:token, Methods.get_token!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Token")
    |> assign(:token, %Token{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> get_tokens()
    |> assign(:page_title, "Lista de Api Tokens")
    |> assign(:token, nil)
  end

  @impl true
  def handle_info({DashboardWeb.TokenLive.FormComponent, {:saved, token}}, socket) do
    {:noreply, stream_insert(socket, :tokens, token)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    token = Methods.get_token!(id)
    {:ok, _} = Methods.delete_token(token)

    {:noreply, stream_delete(socket, :tokens, token)}
  end

  defp get_tokens(socket, url \\ "/api_tokens") do
    headers = ["Accept": "Application/json; Charset=utf-8"]
    DahsboardWeb.HTTP.get("/api/#{url}", headers)
    |> case do
      {:ok, response} ->
        # weather = Methods.change_weather(conn.assigns.changeset |> Ecto.Changeset.apply_changes , response |> Jason.decode!) |> Ecto.Changeset.apply_changes

        tokens =
          response
          |> Jason.decode!
          |> IO.inspect
          |> Enum.reduce([], fn (token, acc) ->
            acc ++ [
              Methods.change_token(%Token{}, token ) |> Ecto.Changeset.apply_changes
            ]
          end)
          |> IO.inspect(label: "TOKENS ->")
        socket
          |> assign(:tokens, tokens)
          |> assign(:errors, "")
      {:error, errors} ->
        socket
          |> assign(:tokens, [])
          |> assign(:errors, Map.get(errors, "error", ""))
    end
  end
end
