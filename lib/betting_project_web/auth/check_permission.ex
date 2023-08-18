defmodule BettingProjectWeb.Auth.CheckPermission do
  alias BettingProjectWeb.ErrorResponse

  def can_user_do?(user, required_permission) do
    user_permissions = _flatten_permissions(user)
    Enum.member?(user_permissions, required_permission)
  end

  def set_up(permission, user) do
    user_access_status = can_user_do?(user, permission)
    if user_access_status != true, do: raise(ErrorResponse.Forbidden)
  end

  defp _flatten_permissions(user) do
    user.users_roles
    |> Enum.flat_map(& &1.role.roles_permissions)
    |> Enum.map(& &1.permission.name)
  end
end
