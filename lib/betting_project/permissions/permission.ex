defmodule BettingProject.Permissions.Permission do
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.RolesPermissions.RolePermission

  schema "permissions" do
    field :name, :string
    has_many(:roles_permissions, RolePermission, on_delete: :delete_all)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :name,
    ])
    |> unique_constraint([:name],
    name: "uidx_permissions_name",
    message: "A permission with this name already exists"
    )
  end
end
