defmodule KYC.TopicOfInterest do
  alias KYC.Schema.Topics

  def insert(topic) do
    Topics.changeset(%Topics{}, topic)
  end
end
