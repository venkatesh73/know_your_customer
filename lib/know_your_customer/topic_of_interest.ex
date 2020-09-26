defmodule KYC.TopicOfInterest do
  alias KYC.Repo
  alias KYC.Schema.Topics
  alias KYC.Users

  def insert(user_id, topics) do
    user_topics = Users.get_topics(user_id)

    user_topics
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:topics, update_users_topics(user_topics.topics, topics))
    |> Repo.update!()
  end

  defp update_users_topics(existing, new) do
    Enum.reduce(new, existing, &[get!(&1) | &2])
  end

  def list() do
    Repo.all(Topics)
  end

  def get!(id), do: Repo.get(Topics, id)

  def delete(user_id, topic) do
    user_topics = Users.get_topics(user_id)

    user_topics
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:topics, user_topics.topics -- [get!(topic)])
    |> Repo.update!()
  end
end
