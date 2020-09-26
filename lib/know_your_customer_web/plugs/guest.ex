defmodule KYCWeb.Plugs.Guest do
  import Plug.Conn
  import Phoenix.Controller

  alias KYC.User

  def init(opts), do: opts

  def call(conn, _opts) do
    if Plug.Conn.get_session(conn, :loggedin_user_id) do
      conn
      |> redirect(to: KYCWeb.Router.Helpers.home_path(conn, :index))
      |> halt()
    end

    conn
  end
end
