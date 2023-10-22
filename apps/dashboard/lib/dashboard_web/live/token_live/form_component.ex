defmodule DashboardWeb.TokenLive.FormComponent do
  use DashboardWeb, :live_component

  alias Dashboard.Methods

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage token records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="token-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:token]} type="text" label="Token" />
        <.input field={@form[:last_hour_count]} type="number" label="Last hour count" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Token</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{token: token} = assigns, socket) do
    changeset = Methods.change_token(token)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"token" => token_params}, socket) do
    changeset =
      socket.assigns.token
      |> Methods.change_token(token_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"token" => token_params}, socket) do
    save_token(socket, socket.assigns.action, token_params)
  end

  defp save_token(socket, :edit, token_params) do
    case Methods.update_token(socket.assigns.token, token_params) do
      {:ok, token} ->
        notify_parent({:saved, token})

        {:noreply,
         socket
         |> put_flash(:info, "Token updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_token(socket, :new, token_params) do
    case Methods.create_token(token_params) do
      {:ok, token} ->
        notify_parent({:saved, token})

        {:noreply,
         socket
         |> put_flash(:info, "Token created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
