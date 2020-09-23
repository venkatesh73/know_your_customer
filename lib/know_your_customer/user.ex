defmodule KYC.Schema.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias KYC.Encryption
  alias KYC.Schema.Topics

  schema "user" do
    field :full_name, :string, null: false
    field :email, :string, null: false
    field :password, :string, virtual: true
    field :encrypted_password, :string, null: false
    field :age, :integer, null: false

    many_to_many :topics, Topics, join_through: "user_topics"

    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:full_name, :email, :password, :age])
    |> validate_required([:full_name, :email, :password, :age])
    |> validate_format(:email, ~r/.+@.+\.[a-zA-Z]{2,3}/)
    |> validate_length(:password, min: 8)
    |> validate_number(:age, greater_than_or_equal_to: 18, less_than_or_equal_to: 100)
    |> unique_constraint(:email, name: "user_email_index")
    |> down_case_email()
    |> encrypt_password()
  end

  def encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :encrypted_password, encrypted_password)
    else
      changeset
    end
  end

  def down_case_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end
end
