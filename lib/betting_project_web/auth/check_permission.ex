defmodule BettingProjectWeb.Auth.CheckPermission do
  def can_user_do?(user, required_permission) do
    user_permissions = _flatten_permissions(user)
    Enum.member?(user_permissions, required_permission)
  end

  defp _flatten_permissions(user) do
    user.users_roles
    |> Enum.flat_map(& &1.role.roles_permissions)
    |> Enum.map(& &1.permission.name)
  end
end
