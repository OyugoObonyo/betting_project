defmodule BettingProjectWeb.UserPermissionController do
  use BettingProjectWeb, :controller
  alias BettingProject.UsersPermissions.UserPermission
  alias BettingProjectWeb.ErrorResponse

  action_fallback(EmailsProjectWeb.FallbackController)

  def add_user_permission(conn, %{"id" => user_id, "permission_id" => permission_id}) do
    with {:ok, _new_user_permission} <-
           UserPermission.create(%{"user_id" => user_id, "permission_id" => permission_id}) do
      conn
      |> put_status(:ok)
      |> json(%{"message" => "User permission addition success"})
    end
  end

  def delete_user_permission(conn, %{"id" => user_id, "permission_id" => permission_id}) do
    with user_permission = %UserPermission{} <-
           UserPermission.find_user_permission(user_id, permission_id),
         {_, _} <-
           UserPermission.delete_by_user_id(user_permission) do
      conn
      |> put_status(:ok)
      |> json(%{"message" => "User permission revoked successfully"})
    else
      _ ->
        raise ErrorResponse.NotFound
    end
  end
end
