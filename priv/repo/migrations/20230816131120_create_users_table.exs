defmodule BettingProject.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password_hash, :string
      add :msisdn, :string
      add :is_deleted, :boolean, default: false
      timestamps()
    end
  end
end
