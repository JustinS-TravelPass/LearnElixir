defmodule GameOfStones.Server do
  @moduledoc """
  Documentation for `GameOfStones.Server`.
  """

  # This means that if the server is stopped normally then don't restart it, if its stop abnormally then restart it.
  use GenServer, restart: :transient
  @server_name __MODULE__

  @doc """
  Hello world.

  ## Examples

      iex> GameOfStones.hello()
      :world

  """

  # Interface functions
  def start_link(_) do
    IO.puts("Starting game of stones server...")
    GenServer.start_link(@server_name, :started, name: @server_name)
  end

  def set_stones(initial_stones_num) do
    GenServer.call(@server_name, {:set_stones, initial_stones_num})
  end

  def take(num_stones) do
    GenServer.call(@server_name, {:take, num_stones})
  end

  # GenServer callbacks
  def init(:started) do
    state =
      case GameOfStones.Storage.fetch() do
        nil -> {1, 0, :started}
        saved_state -> saved_state
      end

    {:ok, state}
  end

  def handle_call({:set_stones, _}, _, {player, num_stones, :game_in_progress} = current_state) do
    {:reply, {player, num_stones, :game_continue}, current_state}
  end

  def handle_call({:set_stones, initial_stones_num}, _, {player, _, :started}) do
    newState = {player, initial_stones_num, :game_in_progress}
    GameOfStones.Storage.store(newState)
    {:reply, newState, newState}
  end

  def handle_call({:take, num_stones}, _, {player, current_stones, :game_in_progress}) do
    reply = do_take({player, num_stones, current_stones})
    GameOfStones.Storage.store(elem(reply, 2))
    reply
  end

  # Private functions
  defp do_take({player, num_stones, current_stones})
       when not is_integer(num_stones) or num_stones < 1 or num_stones > 3 or
              num_stones > current_stones do
    {:reply, {:error, "You can only take 1 to 3 stones at a time!"},
     {player, current_stones, :game_in_progress}}
  end

  defp do_take({player, num_stones, current_stones}) when num_stones == current_stones do
    GameOfStones.Storage.fetch_all() |> IO.inspect()
    {:stop, :normal, {:winner, next_player(player)}, {nil, 0, :game_ended}}
  end

  defp do_take({player, num_stones, current_stones}) do
    next = next_player(player)
    new_stones = current_stones - num_stones
    {:reply, {:next_turn, next, new_stones}, {next, new_stones, :game_in_progress}}
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end
