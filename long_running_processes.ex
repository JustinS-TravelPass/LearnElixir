# This module creates a game called "GAME OF STONES"
# There is a pile of stones with a random count.
# Each player takes a turn and picks up 1-3 stones from the pile.
# The player who picks up the last stone loses.
defmodule GameServer do
  def start() do

    # We give the game server process a name by passing the process to the register function. We also pass an Atom to the second argument to identify the process.
    # We can now reference the process by its name: :game_server
    # We pass in the initial state of the game to the listen function. Which is a tuple containing the player and the total number of stones in the pile.
    spawn(fn -> listen({1, 30}) end) |>
    Process.register(:game_server)
  end

  defp listen({player, current_stones} = current_state) do
    new_state = receive do
      {:take, sender, num_stones} ->
        do_take({sender, player, num_stones, current_stones})
      _ -> current_state
    end

    # This is a tail call. It will continue the recursion until the process is killed.
    listen |> new_state
  end

  defp do_take({sender, player, num_stones_taken, current_stones}) when
  not is_integer(num_stones_taken) or
  num_stones_taken < 1 or
  num_stones_taken > 3 or
  num_stones_taken > current_stones do
    send(sender, {:error, "Invalid number of stones taken!"})

    # Return the current state of the game to the listen function since they took an invalid number of stones.
    {player, current_stones}
  end

  defp do_take({sender, player, num_stones_taken, current_stones}) when
  num_stones_taken == current_stones do
    send(sender, {:winner, next_player(player)})

    {nil, 0}
  end

  defp do_take({sender, player, num_stones_taken, current_stones}) do
    next = next_player(player)
    new_stones_count = current_stones - num_stones_taken
    send(sender, {:next_turn, next, new_stones_count})

    {next, new_stones_count}
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end
