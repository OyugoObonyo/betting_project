defmodule BettingProject.Repo.Migrations.CreateRolesTable do
  use Ecto.Migration

  def change do
    create table("roles") do
      add :name, :string, nullable: false
      timestamps()
    end

    create unique_index(:roles, [:name], name: :uidx_roles_name)
  end
end
