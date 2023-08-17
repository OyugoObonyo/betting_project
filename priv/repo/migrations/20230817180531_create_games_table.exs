defmodule BettingProject.Repo.Migrations.CreateGamesTable do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :home, :string, nullable: false
      add :away, :string, nullable: false
      add :sport_id, references(:sports)

      timestamps()
    end
  end
end
