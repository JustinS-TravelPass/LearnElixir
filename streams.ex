defmodule Streams do
  def transform do
    list() |>
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

Streams.transform() |> IO.inspect # <-- returns 15

Streams.own_stream(3) |> Enum.take(15) |> IO.inspect
