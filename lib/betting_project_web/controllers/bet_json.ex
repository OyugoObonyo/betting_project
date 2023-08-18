defmodule BettingProjectWeb.BetJSON do
  def show(%{bet: bet}) do
    %{
      id: bet.id,
      amount: bet.amount,
      user_id: bet.user_id,
      game_id: bet.game_id
    }
  end

  def profit_loss(%{amount: amount}) do
    if amount > 0 do
      %{
        total_profit: amount
      }
    else
      %{
        total_loss: abs(amount)
      }
    end
  end
end
