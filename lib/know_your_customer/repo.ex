defmodule KYC.Repo do
  use Ecto.Repo,
    otp_app: :know_your_customer,
    adapter: Ecto.Adapters.Postgres
end
