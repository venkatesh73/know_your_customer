defmodule KYC.DataSeeder do
  alias KYC.Repo
  alias KYC.Schema.Topics

  @topics_of_interest "Photography,Space,Sports,Cars,Rock Music,Hip Hop,Hiking,Climbing,Cycling,Retro Dance,Bikes,Moto Cross,PS4,PubG,IPhone,Books,Fiction Story,Sic-Fi Movies,Tom-Cruise,Batman,Marvel Movies,Avengers,Iron-Man"

  def seed() do
    Repo.delete_all(Topics)

    @topics_of_interest
    |> String.split(",", trim: true)
    |> Enum.map(
      &Repo.insert!(%Topics{
        name: &1,
        descp: "Some description about the topic #{&1}."
      })
    )
  end
end

KYC.DataSeeder.seed()
