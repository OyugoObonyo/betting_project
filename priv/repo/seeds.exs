defmodule Seeds do
  alias BettingProject.Repo

  alias BettingProject.Roles.Role
  alias BettingProject.Permissions.Permission
  alias BettingProject.RolesPermissions.RolePermission

  def run(__env) do
    [
      %{name: "admin"}
    ]
    |> Enum.each(fn role ->
      Repo.insert(%Role{name: role.name},
        on_conflict: [set: [name: role.name]],
        conflict_target: [:name]
      )
    end)

    [
      %{name: "superuser"},
      %{name: "canAssignPermission"},
      %{name: "canRevokePermission"},
      %{name: "canAssignRole"},
      %{name: "canRevokeRole"}
    ]
    |> Enum.each(fn permission ->
      Repo.insert(%Permission{name: permission.name},
        on_conflict: [set: [name: permission.name]],
        conflict_target: [:name]
      )
    end)

    [
      %{role_id: 1, permission_id: 2},
      %{role_id: 1, permission_id: 3},
      %{role_id: 1, permission_id: 4},
      %{role_id: 1, permission_id: 5}
    ]
    |> Enum.each(fn role_permission ->
      Repo.insert(
        %RolePermission{
          role_id: role_permission.role_id,
          permission_id: role_permission.permission_id
        },
        on_conflict: [
          set: [role_id: role_permission.role_id, permission_id: role_permission.permission_id]
        ],
        conflict_target: [:role_id, :permission_id]
      )
    end)
  end
end

Seeds.run(Mix.env())
