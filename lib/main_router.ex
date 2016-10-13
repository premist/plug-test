defmodule MainRouter do
  use Plug.Router
  use Responder

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/hello" do
    conn
    |> respond(200, %{hello: "world"})
  end

  match _ do
    conn
    |> error(:not_found)
  end
end