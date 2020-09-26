defmodule KYC.Schema.Topics do
  use Ecto.Schema

  import Ecto.Changeset

  alias KYC.Schema.User

  schema "topics" do
    field :name, :string
    field :descp, :string

    many_to_many :user, User, join_through: "user_topics", on_replace: :delete

    timestamps()
  end

  def changeset(topics, attrs \\ %{}) do
    topics
    |> cast(attrs, [:name, :descp])
    |> validate_required([:name, :descp])
  end
end
