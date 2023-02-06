defmodule Pento.Faq.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :answer, :string
    field :body, :string
    field :votes, :integer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:body, :answer, :votes])
    |> validate_required([:body, :answer, :votes])
  end
end
