defmodule KYC.Users do
  alias KYC.Encryption
  alias KYC.Repo
  alias KYC.Schema.User

  def sign_up(params) do
    case Repo.insert(User.changeset(%User{}, params)) do
      {:ok, user} ->
        authenticate(user, user.password)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def sign_in(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, "Invalid email/password"}

      %User{} = user ->
        authenticate(user, password)
    end
  end

  def authenticate(user, password) do
    case Encryption.validate_password(user, password) do
      {:ok, user} ->
        {:ok, user}

      {:error, _} ->
        {:error, "Invalid email/password"}
    end
  end

  def signed_in?(conn) do
    conn.assigns[:user]
  end

  def get_topics(id) do
    Repo.get(User, id)
    |> Repo.preload([:topics])
  end

  def get_user!(userid) do
    Repo.get(User, userid)
  end
end
