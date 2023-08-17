defmodule BettingProjectWeb.Auth.Plugs.SetUser do
  import Plug.Conn
  alias BettingProjectWeb.Auth.ErrorResponse
  alias BettingProjectWeb.Users.User

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns[:user] do
      conn
    else
      user_id = get_session(conn, :user_id)
      if user_id == nil, do: raise(ErrorResponse.Unauthorized)
      user = User.find_by_id_with_associations(user_id)

      cond do
        user_id && user -> assign(conn, :user, user)
        true -> assign(conn, :user, nil)
      end
    end
  end
end
