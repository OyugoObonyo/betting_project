defmodule BettingProjectWeb.Router do
  use BettingProjectWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BettingProjectWeb do
    pipe_through :api
  end
end
