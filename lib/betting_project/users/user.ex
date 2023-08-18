defmodule BettingProject.Users.User do
  import Ecto.Query
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Repo
  alias BettingProject.Accounts.Account
  alias BettingProject.UsersRoles.UserRole
  alias BettingProject.Bets.Bet

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :msisdn, :string
    field :is_deleted, :boolean, default: false
    has_many(:users_roles, UserRole, on_delete: :delete_all)
    has_many(:bets, Bet)
    has_one(:account, Account, on_delete: :delete_all)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :first_name,
      :last_name,
      :email,
      :is_deleted,
      :msisdn,
      :password_hash,
      :password
    ])
    |> _create_password_hash()
    |> cast_assoc(:account, with: &Account.changeset/2)
    |> validate_required([:first_name, :last_name, :email, :msisdn])
    |> unique_constraint([:email],
      name: "uidx_users_email",
      message: "A user with this email already exists"
    )
  end

  defp _create_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def find_by_id(id) do
    __MODULE__
    |> where([u], u.id == ^id)
    |> Repo.one()
  end

  def find_by_id_with_associations(id) do
    __MODULE__
    |> where([u], u.id == ^id)
    |> Repo.one()
    |> preload_associations()
  end

  def find_by_email_with_associations(email) do
    __MODULE__
    |> where([u], u.email == ^email)
    |> Repo.one()
    |> preload_associations()
  end

  def preload_associations(user) do
    Repo.preload(user, [:account, users_roles: [role: [roles_permissions: [:permission]]]])
  end

  def update(user = %__MODULE__{}, params) do
    user
    |> changeset(params)
    |> Repo.update()
  end

  def delete(user = %__MODULE__{}) do
    user
    |> changeset(%{is_deleted: true})
    |> Repo.update()
  end
end
