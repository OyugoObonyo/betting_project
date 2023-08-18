defmodule BettingProjectWeb.BetController do
  use BettingProjectWeb, :controller
  alias BettingProject.Bets.Bet

  action_fallback(BettingProjectWeb.FallbackController)

  def create(conn, params) do
    user = conn.assigns[:user]

    bet_details = %{
      amount: params["amount"],
      user_id: user.id,
      game_id: params["game_id"]
    }

    IO.inspect(bet_details, label: "PASSED BET DETAILS!")

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
end
