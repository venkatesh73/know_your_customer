defmodule KYCWeb.HomeController do
  use KYCWeb, :controller

  alias KYC.Schema.User
  alias KYC.TopicOfInterest
  alias KYC.Users

  def index(conn, _params) do
    user_id = conn |> get_session(:loggedin_user_id)
    %User{topics: topics} = Users.get_topics(user_id)
    render(conn, "index.html", topics: topics)
  end

  def add(conn, _params) do
    topics = TopicOfInterest.list()
    render(conn, "add.html", topics: topics)
  end

  def create(conn, %{"topics" => %{"topics" => params}}) do
    user_id = conn |> get_session(:loggedin_user_id)

    TopicOfInterest.insert(user_id, params)

    redirect(conn, to: "/")
  end

  def delete(conn, %{"id" => topic}) do
    user_id = conn |> get_session(:loggedin_user_id)

    TopicOfInterest.delete(user_id, topic)

    redirect(conn, to: "/")
  end
end
