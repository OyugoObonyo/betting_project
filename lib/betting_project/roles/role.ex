defmodule BettingProject.Roles.Role do
  import Ecto.Query
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Repo
  alias BettingProject.UsersRoles.UserRole
  alias BettingProject.RolesPermissions.RolePermission

  schema "roles" do
    field :name, :string
    has_many(:users_roles, UserRole, on_delete: :delete_all)
    has_many(:roles_permissions, RolePermission, on_delete: :delete_all)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :name
    ])
    |> validate_required([:name])
    |> unique_constraint([:name],
      name: "uidx_roles_name",
      message: "A role with this name already exists"
    )
  end

  def find_by_name(name) do
    __MODULE__
    |> where([r], r.name == ^name)
    |> Repo.one()
  end
end
