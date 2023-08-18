defmodule BettingProjectWeb.BetJSON do
  def show(%{bet: bet}) do
    %{
      id: bet.id,
      amount: bet.amount,
      user_id: bet.user_id,
      game_id: bet.game_id
    }
  end
end
