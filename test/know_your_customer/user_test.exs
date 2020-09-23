defmodule KYC.UserTest do
  use KYC.DataCase

  alias KYC.Schema.User

  describe "User schema" do
    setup do
      user = %{
        full_name: "Venkatesh Shanmugham",
        email: "venkatesh@gmail.com",
        age: 23,
        password: "strongpassword"
      }

      %{user: user}
    end

    test "invalid email format", %{user: user} do
      user = %{user | email: "venkatesh"}
      user_changeset = User.changeset(%User{}, user)

      {msg, _} = Keyword.get(user_changeset.errors, :email)

      refute user_changeset.valid?
      assert msg == "has invalid format"
    end

    test "invalid password length", %{user: user} do
      user = %{user | password: "weak"}
      user_changeset = User.changeset(%User{}, user)

      {msg, _} = Keyword.get(user_changeset.errors, :password)

      refute user_changeset.valid?
      assert msg == "should be at least %{count} character(s)"
    end

    test "invalid age limit", %{user: user} do
      user = %{user | age: 17}
      user_changeset = User.changeset(%User{}, user)

      {msg, _} = Keyword.get(user_changeset.errors, :age)

      refute user_changeset.valid?
      assert msg == "must be greater than or equal to %{number}"
    end

    test "is_invalid?", %{user: user} do
      user = %{user | full_name: ""}
      user_changeset = User.changeset(%User{}, user)
      refute user_changeset.valid?
    end

    test "is_valid?", %{user: user} do
      user_changeset = User.changeset(%User{}, user)
      assert user_changeset.valid?
    end
  end
end
