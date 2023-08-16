defmodule BettingProject.Repo.Migrations.CreateUsersPermissionsTable do
  use Ecto.Migration

  def change do
    create table(:users_permissions) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :permission_id, references(:permissions)
    end

    create unique_index(:users_permissions, [:user_id, :permission_id],
             name: :uidx_user_permission
           )
  end
end
