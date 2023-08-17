defmodule BettingProjectWeb.Auth.Guardian.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :betting_project,
    module: BettingProjectWeb.Auth.Guardian,
    error_handler: BettingProjectWeb.Auth.Guardian.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
