defmodule BettingProject.UsersRoles.UserRole do
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Users.User
  alias BettingProject.Roles.Role

  schema "users_roles" do
    belongs_to(:user, User, foreign_key: :user_id)
    belongs_to(:role, Role, foreign_key: :role_id)
  end

  def chageset(struct, params) do
    struct
    |> cast(params, [
      :user_id,
      :role_id
    ])
    |> unique_constraint([:user_id, :role_id],
      name: "uidx_user_roles",
      message: "Role-permission combination already exists"
    )
  end
end
