defmodule KYC.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:user) do
      add :full_name, :string, null: false
      add :email, :string, null: false
      add :encrypted_password, :string, null: false
      add :age, :integer, null: false

      timestamps()
    end

    create_if_not_exists unique_index(:user, [:email], name: :user_email_index)
  end
end
