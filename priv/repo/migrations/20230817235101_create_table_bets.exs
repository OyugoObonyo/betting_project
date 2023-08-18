defmodule BettingProject.Repo.Migrations.CreateTableBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :amount, :integer, nullable: false
      add :status, :string, default: "P", nullable: false
      add :user_id, references(:users)
      add :game_id, references(:games)
      timestamps()
    end
  end
end
