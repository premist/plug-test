defmodule Responder do
  defmacro __using__(_opts) do
    quote do
      def error(conn, type) do
        {code, resp} = Responder.error(type)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(code, resp)
      end
    end
  end

  def error(type \\ :internal_server_error)

  def error(:not_found) do
    body = %{
      error: %{
        code: 404,
        message: "Not Found"
      }
    } |> jsonify!
    
    {404, body}
  end

  def error(:internal_server_error) do
    body = %{
      error: %{
        code: 500,
        message: "Internal Server Error"
      }
    } |> jsonify!
    
    {500, body}
  end

  def jsonify!(map) do
    Poison.encode!(map)
  end
end
