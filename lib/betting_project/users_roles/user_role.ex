defmodule BettingProject.UsersRoles.UserRole do
  import Ecto.Query
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Repo
  alias BettingProject.Users.User
  alias BettingProject.Roles.Role

  schema "users_roles" do
    belongs_to(:user, User, foreign_key: :user_id)
    belongs_to(:role, Role, foreign_key: :role_id)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :user_id,
      :role_id
    ])
    |> unique_constraint([:user_id, :role_id],
      name: "uidx_user_roles",
      message: "Role-permission combination already exists"
    )
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:role_id)
  end

  @spec create(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) :: any
  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def find_by_user_id(id) do
    __MODULE__
    |> where([ur], ur.user_id == ^id)
    |> Repo.one()
  end

  def delete_by_user_id(id) do
    __MODULE__
    |> where([ur], ur.user_id == ^id)
    |> Repo.delete_all()
  end
end
