defmodule BettingProject.Accounts.Account do
  import Ecto.Changeset
  use Ecto.Schema

  alias BettingProject.Repo
  alias BettingProject.Users.User
  alias BettingProject.Plans.Plan

  schema "accounts" do
    belongs_to(:plan, Plan, foreign_key: :plan_id)
    belongs_to(:user, User, foreign_key: :user_id)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :plan_id,
      :user_id
    ])
  end

  def update(account = %__MODULE__{}, params) do
    account
    |> changeset(params)
    |> Repo.update()
  end
end
