defmodule BettingProjectWeb.Router do
  use BettingProjectWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug BettingProjectWeb.Auth.Pipeline
    plug BettingProjectWeb.Auth.Plugs.SetUser
  end

  scope "/api", BettingProjectWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/users/login", UserController, :login
  end

  scope "/api", EmailsProjectWeb do
    pipe_through [:api, :auth]

    post "/users/:id/roles", UserRoleController, :assign_user_role
    delete "/users/:id/roles", UserRoleController, :revoke_user_role
    post "/users/:id/permissions", UserPermissionController, :add_user_permission
    delete "/users/:id/permissions", UserPermissionController, :delete_user_permission
  end
end
