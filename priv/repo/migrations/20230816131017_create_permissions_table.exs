defmodule BettingProject.Repo.Migrations.CreatePermissionsTable do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :name, :string, nullable: false
      timestamps()
    end

    create unique_index(:permissions, [:name], name: :uidx_permissions_name)
  end
end
