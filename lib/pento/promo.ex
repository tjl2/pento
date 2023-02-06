defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(recipient, attrs) do
    # send email to promo recipient
    with %Ecto.Changeset{valid?: true} = changeset <- change_recipient(recipient, attrs) do
      {:ok, changeset}
    else
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end
end
