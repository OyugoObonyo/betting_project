defmodule BettingProjectWeb.GameJSON do
  def show(%{game: game}) do
    %{
      id: game.id,
      home: game.home,
      away: game.away,
      sport_id: game.sport_id
    }
  end
end
