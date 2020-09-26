defmodule KYC.Repo.Migrations.CreateUserTopics do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:user_topics) do
      add :user_id, references(:user)
      add :topics_id, references(:topics)
    end

    create_if_not_exists unique_index(:user_topics, [:user_id, :topics_id],
                           name: :user_topics_index
                         )
  end
end
