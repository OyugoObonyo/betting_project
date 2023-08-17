defmodule BettingProject.Games.Game do
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Repo
  alias BettingProject.Sports.Sport
  alias BettingProject.Bets.Bet

  schema "games" do
    field :home, :string
    field :away, :string
    has_many(:bets, Bet)
    belongs_to(:sport, Sport, foreign_key: :sport_id)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :home,
      :away,
      :sport_id
    ])
    |> validate_required([:home, :away, :sport_id])
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end
end
