defmodule BettingProject.Repo.Migrations.CreateUsersRolesTable do
  use Ecto.Migration

  def change do
    create table(:users_roles) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)
      timestamps()
    end

    create unique_index(:users_roles, [:user_id, :role_id], name: :uidx_user_roles)
  end
end
