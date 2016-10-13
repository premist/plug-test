defmodule MainRouter do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/hello" do
    conn
    |> send_resp(200, "world")
  end

  match _ do
    conn
    |> send_resp(404, "oops")
  end
end