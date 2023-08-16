defmodule BettingProjectWeb.UserJSON do
  def show(%{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      msisdn: user.msisdn
    }
  end

  def user_login(%{user: user, token: token}) do
    %{
      user: show(%{user: user}),
      session: %{
        access_token: token
      }
    }
  end
end
