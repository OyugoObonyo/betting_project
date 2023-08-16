defmodule BettingProject.Repo do
  use Ecto.Repo,
    otp_app: :betting_project,
    adapter: Ecto.Adapters.Postgres
end
