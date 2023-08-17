defmodule BettingProject.Repo.Migrations.CreateSportsTable do
  use Ecto.Migration

  def change do
    create table(:sports) do
      add :name, :string, nullable: false
      timestamps()
    end

    create unique_index(:sports, [:name], name: :uidx_sport_name)
  end
end
