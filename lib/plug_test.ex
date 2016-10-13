defmodule PlugTest do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = Application.get_env(:plug_test, :port)

    # Define workers and child supervisors to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, MainRouter, [], [port: port])
      # Starts a worker by calling: PlugTest.Worker.start_link(arg1, arg2, arg3)
      # worker(PlugTest.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlugTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
