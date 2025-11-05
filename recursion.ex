# list = [1,2,3,4,5]
# [head | tail] = list
# [x, y | tail] = list
# head = hd list
# tail = tl list

defmodule Recursion.Calc do
  def factorial(0), do: 1
  def factorial(a) when is_integer(a) and a > 0, do: a * factorial(a - 1)
  def factorial(_), do: {:error, :invalid_argument}
end

defmodule Recursion.ListUtils do
  def alt_max([head | tail]), do: alt_max(tail, head)
  def alt_max([head | tail], current_maximum) when current_maximum < head do
    alt_max(tail, head)
  end
  def alt_max([head | tail], current_maximum) when current_maximum >= head do
    alt_max(tail, current_maximum)
  end
  def alt_max([], current_maximum), do: current_maximum

  def max([current_maximum, head | tail ]) when current_maximum < head do
    max([head | tail])
  end

  # If the first current_maximum in the tail is greater than or equal to the current_maximum then we call "max" again and pass in a new list with the current_maximum as the head and the new tail
  def max([current_maximum, head | tail ]) when current_maximum >= head do
    max([current_maximum | tail])
  end

  #Found maximum current_maximum in the list
  def max([current_maximum]), do: current_maximum

  # This acts as the boundary for the recursive map function.
  def map([], _fun), do: []
  # The map funciton has an Arity of /2. First is a a destructured list containing a head and a tail.
  # The second is a lambda function.
  # The funciton will recursively create a new list by applying the lambda function to the head of the list and then calling the map function again with the tail of the list.
  def map([head | tail], fun) do
    [fun.(head) | map(tail, fun)]
  end

  def mult([]), do: 1
  def mult([head | tail]) do
    head * mult(tail)
  end
end

Recursion.ListUtils.mult([1,2,3,4,5]) |> IO.puts

Recursion.ListUtils.map([1,2,3,4,5], &(&1 * 3)) |> IO.inspect

Recursion.ListUtils.max([3,1,5,2,9,10]) |> IO.puts

Recursion.ListUtils.alt_max([3,1,5,2,88,9,10]) |> IO.puts
