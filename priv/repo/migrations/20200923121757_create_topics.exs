defmodule KYC.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:topics) do
      add :name, :string, null: false
      add :descp, :string, null: false

      timestamps()
    end
  end
end
