defmodule BettingProject.Bets.Bet do
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
      :amount,
      :status
    ])
    |> validate_required([:amount, :status])
    |> validate_inclusion(:status, ["P", "W", "D"])
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end
end

defmodule BettingProject.Repo.Migrations.CreateBetsTable do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :home, :string, nullable: false
      add :away, :string, nullable: false
      add :status, :string, default: "P", nullable: false
      add :user_id, references(:users)
      add :game_id, references(:games)
    end
  end
end
