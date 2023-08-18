defmodule BettingProject.RolesPermissions.RolePermission do
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Roles.Role
  alias BettingProject.Permissions.Permission

  schema "roles_permissions" do
    belongs_to(:role, Role, foreign_key: :role_id)
    belongs_to(:permission, Permission, foreign_key: :permission_id)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :role_id,
      :permission_id
    ])
    |> unique_constraint([:role_id, :permission_id],
      name: "uidx_role_permission",
      message: "Role-permission combination already exists"
    )
  end
end
