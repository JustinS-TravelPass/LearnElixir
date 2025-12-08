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
  # This main function is requires to run this as EScript.
  def main(argv) do
    parse(argv) |> play()
  end

  # Parse is used here to parse the arguments passed to the script from the command line.
  # Run "mix escript.build" to build the escript.
  # Run "game_of_stones --stones=10" to start the game with 10 stones.
  def parse(arguments) do
    {opts, _, _} = OptionParser.parse(arguments, switches: [stones: :integer])
    IO.inspect(opts)
    opts |> Keyword.get(:stones, 30)
  end

  def play(initial_stones_num \\ 30) do
    GameOfStones.Server.start(initial_stones_num)
    start_game!()
  end

  # Private functions
  defp start_game! do
    case GameOfStones.Server.stats() do
      {player, stones} ->
        message = "Welcome! It's player #{player}'s turn with #{stones} stones in the pile."
        IO.puts(Colors.green(message))
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
