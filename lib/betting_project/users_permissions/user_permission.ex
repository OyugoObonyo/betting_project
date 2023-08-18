defmodule BettingProject.UsersPermissions.UserPermission do
  import Ecto.Query
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Repo
  alias BettingProject.Users.User
  alias BettingProject.Permissions.Permission

  schema "users_permissions" do
    belongs_to(:user, User, foreign_key: :user_id)
    belongs_to(:permission, Permission, foreign_key: :permission_id)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :user_id,
      :permission_id
    ])
    |> unique_constraint([:role_id, :permission_id],
      name: "uidx_user_permission",
      message: "User-permission combination already exists"
    )
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def find_user_permission(user_id, permission_id) do
    __MODULE__
    |> where([ur], ur.user_id == ^user_id and ur.permission_id == ^permission_id)
    |> Repo.one()
  end

  def delete_by_user_id(user_permission = %__MODULE__{}) do
    user_permission
    |> Repo.delete()
  end
end
