defmodule KYCWeb.HomeControllerTest do
  use KYCWeb.ConnCase
  alias KYC.Repo
  alias KYC.Schema.User

  alias KYC.Repo
  alias KYC.Schema.Topics

  @valid_attributes %{
    "full_name" => "Venkatesh Shanmugham",
    "email" => "venkatesh@gmail.com",
    "age" => 25,
    "password" => "password123"
  }

  describe "Unauthorized access" do
    test "unauthorized access reidrected to login", %{conn: conn} do
      conn = get(conn, Routes.home_path(conn, :index))
      assert redirected_to(conn) =~ "/login"
    end
  end

  describe "Autjorized access" do
    setup %{conn: conn} do
      {:ok, user} = fixture(:singup)

      conn =
        conn
        |> Plug.Test.init_test_session(loggedin_user_id: user.id)

      {:ok, conn: conn}
    end

    test "/", %{conn: conn} do
      conn = get(conn, Routes.home_path(conn, :index))
      assert html_response(conn, 200) =~ "User Topics of Interes"
    end

    test "/add", %{conn: conn} do
      topics = fixture(:topics)

      selected_topics = [List.first(topics).id]
      selected_topics = [List.last(topics).id | selected_topics]

      conn = get(conn, Routes.home_path(conn, :add))
      assert html_response(conn, 200) =~ "Add User Topics of Interest"

      conn = post(conn, Routes.home_path(conn, :create, topics: %{"topics" => selected_topics}))
      assert redirected_to(conn) =~ "/"

      conn = get(conn, Routes.home_path(conn, :index))
      assert html_response(conn, 200) =~ "Photography"
      assert html_response(conn, 200) =~ "Some description about the topic Photography."
    end

    test "/delete", %{conn: conn} do
      topics = fixture(:topics)

      selected_topics = [List.first(topics).id]
      selected_topics = [List.last(topics).id | selected_topics]

      conn = get(conn, Routes.home_path(conn, :index))
      assert html_response(conn, 200) =~ "User Topics of Interes"

      conn = post(conn, Routes.home_path(conn, :create, topics: %{"topics" => selected_topics}))
      assert redirected_to(conn) =~ "/"

      conn = get(conn, Routes.home_path(conn, :index))
      assert html_response(conn, 200) =~ "Photography"
      assert html_response(conn, 200) =~ "Some description about the topic Photography."

      conn = delete(conn, Routes.home_path(conn, :delete, List.first(topics).id))
      assert redirected_to(conn) =~ "/"

      conn = get(conn, Routes.home_path(conn, :index))
      refute html_response(conn, 200) =~ "Photography"
      refute html_response(conn, 200) =~ "Some description about the topic Photography."
    end
  end

  def fixture(:singup) do
    Repo.insert(User.changeset(%User{}, @valid_attributes))
  end

  def fixture(:topics) do
    Enum.map(
      ["Photography", "Space", "Sports", "Cars", "Rock Music"],
      &Repo.insert!(%Topics{
        name: &1,
        descp: "Some description about the topic #{&1}."
      })
    )
  end
end
