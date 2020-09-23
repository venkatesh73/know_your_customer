defmodule KYCWeb.Plugs.Authorized do
  import Plug.Conn
  import Phoenix.Controller

  alias KYC.Users

  def init(opts), do: opts

  def call(conn, _opts) do
    if user_id = Plug.Conn.get_session(conn, :loggedin_user_id) do
      current_user = Users.get_user!(user_id)
      conn 
      |> assign(:user, current_user)
    else
      conn
      |> redirect(to: "/login")
      |> halt()
    end
  end
end