defmodule GenGameOfStones.GameServer do
  use GenServer
  @server_name __MODULE__

  # Interface functions
  def start(initial_stones_num \\ 30) do
    GenServer.start(@server_name, initial_stones_num, name: @server_name)
  end

  def stats do
    GenServer.call(@server_name, :stats)
  end

  def take(num_stones) do
    GenServer.call(@server_name, {:take, num_stones})
  end

  # GenServer callbacks
  def init(initial_stones_num) do
    {:ok, {1, initial_stones_num}}
  end

  def handle_call(:stats, _, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_call({:take, num_stones}, _, {player, current_stones}) do
    do_take({player, num_stones, current_stones})
  end

  def terminate(_, _) do
    IO.puts("Game over!")
  end

  # Private functions
  defp do_take({player, num_stones, current_stones})
       when not is_integer(num_stones) or num_stones < 1 or num_stones > 3 or
              num_stones > current_stones do
    {:reply, {:error, "You can only take 1 to 3 stones at a time!"}, {player, current_stones}}
  end

  defp do_take({player, num_stones, current_stones}) when num_stones == current_stones do
    {:stop, :normal, {:winner, next_player(player)}, {nil, 0}}
  end

  defp do_take({player, num_stones, current_stones}) do
    next = next_player(player)
    new_stones = current_stones - num_stones
    {:reply, {:next_turn, next, new_stones}, {next, new_stones}}
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end

defmodule GenGameOfStones.GameClient do
  def play(initial_stones_num \\ 30) do
    GenGameOfStones.GameServer.start(initial_stones_num)
    start_game!()
  end

  # Private functions
  defp start_game! do
    case GenGameOfStones.GameServer.stats() do
      {player, stones} ->
        IO.puts("Welcome! It's player #{player}'s turn with #{stones} stones in the pile.")
    end

    take()
  end

  defp take() do
    case GenGameOfStones.GameServer.take(ask_stones()) do
      {:next_turn, next_player, new_stones} ->
        IO.puts("\nPlayer #{next_player} turn! #{new_stones} stones left.")
        take()

      {:winner, winner} ->
        IO.puts("\nPlayer #{winner} wins!")

      {:error, reason} ->
        IO.puts("\nError: #{reason}")
        take()
    end
  end

  defp ask_stones() do
    IO.gets("How many stones do you want to take? (1-3):")
    |> String.trim()
    |> Integer.parse()
    |> handle_ask_stones
  end

  defp handle_ask_stones({count, _}), do: count
  defp handle_ask_stones(:error), do: 0
end

GenGameOfStones.GameClient.play(10)
