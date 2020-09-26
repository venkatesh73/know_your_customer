defmodule KYCWeb.SessionController do
  use KYCWeb, :controller

  alias KYC.Schema.User
  alias KYC.Users

  def index(conn, _params) do
    render(conn, "sign_in.html")
  end

  def submit(conn, %{"login" => params}) do
    case Users.sign_in(params) do
      {:ok, user} ->
        conn
        |> put_session(:loggedin_user_id, user.id)
        |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: Routes.home_path(conn, :index))

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> render("sign_in.html")
    end
  end

  def sign_up(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "sign_up.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Users.sign_up(params) do
      {:ok, user} ->
        conn
        |> put_session(:loggedin_user_id, user.id)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: Routes.home_path(conn, :index))

      {:error, changeset} ->
        render(conn, "sign_up.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_req_header("authorization")
    |> configure_session(drop: true)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: "/login")
  end
end
