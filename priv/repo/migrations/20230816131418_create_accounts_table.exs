defmodule BettingProject.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end
  end
end
