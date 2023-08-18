defmodule BettingProject.Bets.Bet do
  import Ecto.Query
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Repo
  alias BettingProject.Users.User
  alias BettingProject.Games.Game

  schema "bets" do
    field :amount, :integer
    field :status, :string, default: "P"
    belongs_to(:user, User, foreign_key: :user_id)
    belongs_to(:game, Game, foreign_key: :game_id)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :user_id,
      :game_id,
      :amount,
      :status
    ])
    |> validate_required([:amount, :user_id, :game_id])
    |> validate_inclusion(:status, ["P", "W", "L"])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:game_id)
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def find_game_profit_loss(game_id) do
    wins_query = from(g in __MODULE__, where: g.game_id == ^game_id and g.status == "W")
    loss_query = from(g in __MODULE__, where: g.game_id == ^game_id and g.status == "L")
    Repo.aggregate(loss_query, :sum, :amount) - Repo.aggregate(wins_query, :sum, :amount)
  end
end
