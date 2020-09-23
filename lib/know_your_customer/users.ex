defmodule KYC.Users do
  alias KYC.Schema.User

  def sign_up(params) do
    params
  end

  def sign_in(params) do
    {:ok, params}
  end

  def signed_in?(conn) do
    conn.assigns[:user]
  end

  def get_user!(_id) do
    %{}
  end
end
