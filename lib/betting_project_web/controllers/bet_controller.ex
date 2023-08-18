defmodule BettingProjectWeb.BetController do
  use BettingProjectWeb, :controller
  alias BettingProject.Bets.Bet
  alias BettingProject.Games.Game
  alias BettingProjectWeb.ErrorResponse
  alias BettingProjectWeb.Auth.CheckPermission

  action_fallback(BettingProjectWeb.FallbackController)

  def create(conn, params) do
    user = conn.assigns[:user]

    with {:ok, bet} <-
           Bet.create(%{
             "amount" => params["amount"],
             "user_id" => user.id,
             "game_id" => params["game_id"]
           }) do
      conn
      |> put_status(:created)
      |> render(:show, bet: bet)
    end
  end

  def view_profit_loss(conn, %{"game_id" => game_id}) do
    user = conn.assigns[:user]
    required_permission = "canViewGameProfitLoss"
    CheckPermission.set_up(required_permission, user)

    with _game = %Game{} <- Game.find_by_id(game_id) do
      amount = Bet.find_game_profit_loss(game_id)

      conn
      |> put_status(:ok)
      |> render(:profit_loss, amount: amount)
    else
      nil ->
        raise ErrorResponse.NotFound
    end
  end
end
