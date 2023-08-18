defmodule BettingProjectWeb.GameController do
  use BettingProjectWeb, :controller
  alias BettingProject.Games.Game

  action_fallback(BettingProject.FallbackController)

  def add_game(conn, params) do
    with {:ok, game} <- Game.create(params) do
      conn
      |> put_status(:created)
      |> render(:show, game: game)
    end
  end
end
