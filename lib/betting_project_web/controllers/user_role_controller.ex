defmodule BettingProjectWeb.UserRoleController do
  use BettingProjectWeb, :controller
  alias BettingProject.UsersRoles.UserRole
  alias BettingProjectWeb.Auth.CheckPermission
  alias BettingProjectWeb.Auth.ErrorResponse

  action_fallback(BettingProjectWeb.FallbackController)

  def assign_user_role(conn, %{"id" => user_id, "role_id" => role_id}) do
    user = conn.assigns[:user]
    required_permission = "canAssignRole"
    user_access_status = CheckPermission.can_user_do?(user, required_permission)
    if user_access_status != true, do: raise(ErrorResponse.Forbidden)

    case UserRole.find_by_user_id(user_id) do
      %UserRole{} ->
        UserRole.delete_by_user_id(user_id)

        with {:ok, _user_role} <- UserRole.create(%{"user_id" => user_id, "role_id" => role_id}) do
          conn
          |> put_status(:ok)
          |> json(%{"message" => "User role addition success"})
        end

      nil ->
        with {:ok, _user_role} <- UserRole.create(%{"user_id" => user_id, "role_id" => role_id}) do
          conn
          |> put_status(:ok)
          |> json(%{"message" => "User role addition success"})
        end
    end
  end

  def revoke_user_role(conn, %{"id" => user_id}) do
    user = conn.assigns[:user]
    required_permission = "canRevokeRole"
    user_access_status = CheckPermission.can_user_do?(user, required_permission)
    if user_access_status != true, do: raise(ErrorResponse.Forbidden)

    with _user_role = %UserRole{} <- UserRole.find_by_user_id(user_id),
         {_, _} <-
           UserRole.delete_by_user_id(user_id) do
      conn
      |> put_status(:ok)
      |> json(%{"message" => "User role revoked successfully"})
    else
      nil -> raise ErrorResponse.NotFound
    end
  end
end
