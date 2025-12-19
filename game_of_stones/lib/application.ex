defmodule GameOfStones.Application do
  use Application

  def start(_type, _args) do
    # Define processes to Supervise
    children = [
      GameOfStones.Server
    ]

    opts = [
      # Defines what to do when a child process dies.
      # One for one means that if one child process dies, only that process will be restarted.
      strategy: :one_for_one,
      name: GameOfStones.Supervisor
    ]

    # Start the supervisor and return the supervisor pid.
    Supervisor.start_link(children, opts)
  end
end
