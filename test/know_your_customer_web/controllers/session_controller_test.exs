defmodule KYCWeb.SessionControllerTest do
  use KYCWeb.ConnCase

  alias KYC.Repo
  alias KYC.Schema.User

  @valid_attributes %{
    "full_name" => "Venkatesh Shanmugham",
    "email" => "venkatesh@gmail.com",
    "age" => 25,
    "password" => "password123"
  }

  @invalid_attributes %{@valid_attributes | "age" => 15}

  describe "User registration" do
    test "/sign_up", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :sign_up))
      assert html_response(conn, 200) =~ "Sign Up"
    end

    test "sign-up with invalid params", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), user: @invalid_attributes)
      assert html_response(conn, 200) =~ "Sign Up"
      assert html_response(conn, 200) =~ "must be greater than or equal to 18"
    end

    test "sign-up with valid params", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create, user: @valid_attributes))

      assert redirected_to(conn) == Routes.home_path(conn, :index)

      conn = get(conn, Routes.home_path(conn, :index))
      assert html_response(conn, 200) =~ "User Topics of Interes"
    end
  end

  describe "sign-in" do
    test "/login", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :index))
      assert html_response(conn, 200) =~ "Login"
    end

    test "login-with-invalid-creds", %{conn: conn} do
      {:ok, _} = fixture(:singup)

      login_creds = %{"email" => "venkatesh@gmail.com", "password" => "passwo"}

      conn = post(conn, Routes.session_path(conn, :submit, login: login_creds))
      assert html_response(conn, 200) =~ "Invalid email/password"
    end

    test "login-with-valid-creds", %{conn: conn} do
      {:ok, _} = fixture(:singup)

      login_creds = %{"email" => "venkatesh@gmail.com", "password" => "password123"}

      conn = post(conn, Routes.session_path(conn, :submit, login: login_creds))
      assert redirected_to(conn) == Routes.home_path(conn, :index)

      conn = get(conn, Routes.home_path(conn, :index))
      assert html_response(conn, 200) =~ "User Topics of Interes"
    end
  end

  describe "logout" do
    test "log-out", %{conn: conn} do
      {:ok, _} = fixture(:singup)

      login_creds = %{"email" => "venkatesh@gmail.com", "password" => "password123"}

      conn = post(conn, Routes.session_path(conn, :submit, login: login_creds))
      assert redirected_to(conn) == Routes.home_path(conn, :index)

      conn = delete(conn, Routes.session_path(conn, :delete))
      assert redirected_to(conn) == Routes.session_path(conn, :index)
    end
  end

  def fixture(:singup) do
    Repo.insert(User.changeset(%User{}, @valid_attributes))
  end
end
