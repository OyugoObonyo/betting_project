defmodule BettingProjectWeb.GameController do
  use BettingProjectWeb, :controller
  alias BettingProject.Games.Game
  alias BettingProjectWeb.ErrorResponse
  alias BettingProjectWeb.Auth.CheckPermission

  action_fallback(BettingProjectWeb.FallbackController)

  def create(conn, params) do
    user = conn.assigns[:user]
    required_permission = "canAddGame"
    user_access_status = CheckPermission.can_user_do?(user, required_permission)
    if user_access_status != true, do: raise(ErrorResponse.Forbidden)

    with {:ok, game} <- Game.create(params) do
      conn
      |> put_status(:created)
      |> render(:show, game: game)
    end
  end
end
