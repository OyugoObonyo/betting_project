defmodule BettingProject.Repo.Migrations.CreateRolesPermissionsTable do
  use Ecto.Migration

  def change do
    create table(:roles_permissions) do
      add :role_id, references(:roles, on_delete: :delete_all)
      add :permission_id, references(:permissions)
      timestamps()
    end

    create unique_index(:roles_permissions, [:role_id, :permission_id],
             name: :uidx_role_permission
           )
  end
end
