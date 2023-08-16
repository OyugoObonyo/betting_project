defmodule BettingProjectWeb.UserRoleController do
  use BettingProjectWeb, :controller
  alias BettingProject.UsersRoles.UserRole

  action_fallback(EmailsProjectWeb.FallbackController)

  def assign_user_role(conn, %{"id" => user_id, "role_id" => role_id}) do
    with _user_role <- UserRole.find_by_user_id(user_id),
         {_, _} <- UserRole.delete_by_user_id(user_id),
         {:ok, _new_user_role} <- UserRole.create(%{"user_id" => user_id, "role_id" => role_id}) do
      conn
      |> put_status(:ok)
      |> json(%{"message" => "User role addition success"})
    end
  end

  def revoke_user_role(conn, %{"id" => user_id}) do
    with _user_role = UserRole.find_by_user_id(user_id),
         {_, _} <-
           UserRole.delete_by_user_id(user_id) |> IO.inspect(label: "Delete function return") do
      conn
      |> put_status(:ok)
      |> json(%{"message" => "User role revoked succesfully"})
    else
      nil ->
        conn
        |> put_status(404)
        |> json(%{"message" => "User role combination not found"})
    end
  end
end
