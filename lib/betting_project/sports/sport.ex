defmodule BettingProject.Sports.Sport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sports" do
    field :name, :string
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :name
    ])
    |> unique_constraint([:name],
      name: "uidx_sport_name",
      message: "A sport with this name already exists"
    )
  end
end
