# This module creates a game called "GAME OF STONES"
# There is a pile of stones with a random count.
# Each player takes a turn and picks up 1-3 stones from the pile.
# The player who picks up the last stone loses.
# Powered by a long running recursive server process.
defmodule GameServer do
  def start() do
    ask_how_many_stones()
  end

  def exit_listener do
    receive do
      {:exit, _} -> exit :normal
    end
  end

  defp ask_how_many_stones() do
    IO.gets("\nHow many stones do you want to play with? (1-100):") |>
    String.trim |>
    Integer.parse |>
    handle_how_many_stones
  end

  defp handle_how_many_stones({stones, _}) when is_integer(stones) and stones >= 1 and stones <= 100 do
    # We give the game server process a name by passing the process to the register function. We also pass an Atom to the second argument to identify the process.
    # We can now reference the process by its name: :game_server
    # We pass in the initial state of the game to the listen function. Which is a tuple containing the player and the total number of stones in the pile.
    spawn(fn -> listen({1, stones}) end) |>
    Process.register(:game_server)
  end

  defp handle_how_many_stones(_) do
    IO.puts("Invalid number of stones. Please enter a number between 1 and 100.")
    ask_how_many_stones()
  end

  defp listen({nil, 0}) do
    IO.puts("Game over!")
  end

  defp listen({player, current_stones} = current_state) do
    new_state = receive do
      {:info, sender} -> do_info({sender, current_state})
      {:take, sender, num_stones} -> do_take({sender, player, num_stones, current_stones})
      _ -> current_state
    end

    # This is a tail call. It will continue the recursion until the process is killed.
    listen(new_state)
    exit_listener()
  end

  defp do_info({sender, current_state}) do
    send(sender, current_state)
    current_state
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
    send(sender, {:next_turn, next, num_stones_taken, new_stones_count})

    {next, new_stones_count}
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end

defmodule GameClient do
  require Integer

  def play() do
    IO.puts("<> WELCOME TO THE GAME OF STONES <>")

    GameServer.start()

    start_game!()
  end

  defp start_game!() do
    send(:game_server, {:info, self()})

    receive do
      {current_player, current_stones} ->
        IO.puts("Game started! Player #{current_player} starts with #{current_stones} stones in the pile.")
    end

    take(1)
  end

  def exit_game() do
    send(:game_server, {:exit, self()})
  end

  defp take(current_player) do
    send(:game_server, {:take, self(), ask_stones(current_player)})

    receive do
      {:next_turn, next_player, stones_taken, new_stones_count} ->
        IO.puts("Player #{current_player} takes #{stones_taken} stones. #{new_stones_count} stones left.")
        take(next_player)
      {:winner, winner} ->
        IO.puts("Player #{winner} wins!")
        ask_restart()
      {:error, reason} ->
        IO.puts("Error: #{reason}")
        take(current_player)
      after 5000 -> IO.puts(:stderr, "Server Timeout!")
    end
  end

  defp ask_restart() do
    IO.gets("\nDo you want to play again? (y/n):") |>
    String.trim |>
    String.downcase() |>
    handle_restart
  end

  defp handle_restart(answer) do
    cond do
      String.starts_with?(answer, "y") -> play()
      String.starts_with?(answer, "n") ->
        IO.puts("Thanks for playing!")
        exit_game()
      true ->
        IO.puts("Invalid answer. Please enter 'y' or 'n'.")
        ask_restart()
    end
  end

  defp ask_stones(current_player) do
    IO.gets("\nPlayer #{current_player}, please take from 1 to 3 stones:") |>
    String.trim |>
    Integer.parse |>
    handle_ask_stones
  end

  defp handle_ask_stones({count, _}), do: count
  defp handle_ask_stones(:error), do: nil
end

GameClient.play()
