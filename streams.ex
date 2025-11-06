defmodule Streams do

  # When you pass one stream to another stream its called a composition.
  # Streams return an enumerable.
  def transform(list \\ list()) do
    list |>
    Stream.map(&(&1 * &1)) |>
    Stream.drop_every(3) |>
    Enum.reduce(0, &(&1 + &2))
  end

  def own_stream(multiplier) do
    Stream.iterate(1, &(&1 * multiplier))
  end

  def list do
    [1,2,3,4,5,6,7,8,9,10]
  end
end

Streams.transform(1..1_000_000) |> IO.inspect # <-- returns 15

Streams.own_stream(3) |> Enum.take(15) |> IO.inspect
