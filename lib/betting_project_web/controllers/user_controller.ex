defmodule BettingProjectWeb.UserController do
  use BettingProjectWeb, :controller
  alias BettingProjectWeb.Auth.Guardian
  alias BettingProjectWeb.ErrorResponse
  alias BettingProject.Users.User

  action_fallback(BettingProjectWeb.FallbackController)

  def create(conn, params) do
    with {:ok, user} <- User.create(params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        conn
        |> Plug.Conn.put_session(:user_id, user.id)
        |> put_status(:ok)
        |> render(:user_login, %{user: user, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Incorrect email or password"
    end
  end
end
