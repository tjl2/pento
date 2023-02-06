defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign_recipient()
      |> assign_changeset()}
  end

  @impl true
   def handle_event("validate", %{"recipient" => recipient_params}, %{assigns: %{recipient: recipient}} = socket) do
      changeset =
        recipient
        |> Promo.change_recipient(recipient_params)
        |> Map.put(:action, :validate)

      {:noreply,
        socket
        |> assign(:changeset, changeset)}
   end

  @impl true
   def handle_event("save", %{"recipient" => recipient_params}, %{assigns: %{recipient: recipient}} = socket) do
    changeset =
      recipient
      |> Promo.send_promo(recipient_params)

    case changeset do
      {:ok, _recipient} ->
        {:noreply,
          socket
          |> put_flash(:info, "Email sent successfully")
          |> push_redirect(to: Routes.live_path(socket, __MODULE__))}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
          socket
          |> put_flash(:error, "Invalid recipient")
          |> assign(:changeset, changeset)}
    end
   end

  defp assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  defp assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket
    |> assign(:changeset, Promo.change_recipient(recipient))
  end
end
