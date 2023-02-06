defmodule Pento.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :body, :text
      add :answer, :text
      add :votes, :integer

      timestamps()
    end
  end
end
