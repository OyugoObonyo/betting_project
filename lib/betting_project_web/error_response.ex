defmodule BettingProjectWeb.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule BettingProjectWeb.ErrorResponse.Forbidden do
  defexception message: "Access forbidden", plug_status: 403
end

defmodule BettingProjectWeb.ErrorResponse.NotFound do
  defexception message: "Resource not found", plug_status: 404
end
