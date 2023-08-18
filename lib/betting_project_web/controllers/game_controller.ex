defmodule BettingProjectWeb.GameController do
  use BettingProjectWeb, :controller
  alias BettingProject.Games.Game
  alias BettingProjectWeb.Auth.CheckPermission

  action_fallback(BettingProjectWeb.FallbackController)

  def create(conn, params) do
    user = conn.assigns[:user]
    required_permission = "canAddGame"
    CheckPermission.set_up(required_permission, user)

    with {:ok, game} <- Game.create(params) do
      conn
      |> put_status(:created)
      |> render(:show, game: game)
    end
  end
end
