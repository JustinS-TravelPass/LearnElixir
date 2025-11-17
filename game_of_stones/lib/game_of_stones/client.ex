defmodule GameOfStones.Client do
  @moduledoc """
  Documentation for `GameOfStones.Client`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GameOfStones.hello()
      :world

  """
  def play(initial_stones_num \\ 30) do
    GameOfStones.Server.start(initial_stones_num)
    start_game!()
  end

  # Private functions
  defp start_game! do
    case GameOfStones.Server.stats() do
      {player, stones} ->
        IO.puts("Welcome! It's player #{player}'s turn with #{stones} stones in the pile.")
    end

    take()
  end

  defp take() do
    case GameOfStones.Server.take(ask_stones()) do
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
