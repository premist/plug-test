defmodule Responder do
  defmacro __using__(_opts) do
    quote do
      def error(conn, type) do
        {code, resp} = Responder.error(type)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(code, resp)
      end

      def respond(conn, code \\ 200, body) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(code, body |> Responder.jsonify!)
      end
    end
  end

  def error(type \\ :internal_server_error)

  def error(:not_found) do
    code = 404
    body = %{
      error: %{
        code: code,
        message: "Not Found"
      }
    } |> jsonify!
    
    {code, body}
  end

  def error(:internal_server_error) do
    code = 500
    body = %{
      error: %{
        code: code,
        message: "Internal Server Error"
      }
    } |> jsonify!
    
    {code, body}
  end

  def jsonify!(map) do
    Poison.encode!(map)
  end
end
