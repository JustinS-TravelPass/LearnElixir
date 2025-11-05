defmodule TailCalls.Calc do
  # def mult() do
  #   #do something...

  #   mult() # <- This is a tail call. This allows us to avoid overuse of memory.
  # end

  def alt_mult(list), do: do_alt_mult([1 | list])
  def do_alt_mult([current_value | []]), do: current_value
  def do_alt_mult([current_value, head | tail]) do
    do_alt_mult([current_value * head | tail]) # <- This is a tail call! This allows us to avoid overuse of memory while recursively calling the function.
  end

  def mult(list), do: do_mult(1, list)
  defp do_mult(current_value, []), do: current_value
  defp do_mult(current_value, [head | tail]) do
    do_mult(current_value * head, tail)
  end

  # If no arugment was provided then return an error.
  def fact(_), do: {:error, :invalid_argument}
  # If the argument is an int AND less than 0 OR its not an int then return an error.
  def fact(a) when is_integer(a) and a < 0 or not is_integer(a), do: {:error, :invalid_argument}
  #If the parameter is 0 then return 1.
  def fact(0), do: 1
  def fact(a), do: do_fact(1, a)
  defp do_fact(result, 0), do: result
  defp do_fact(result, a) do
    result * a |>
    do_fact(a - 1)
  end
end

TailCalls.Calc.mult([1,2,3,4,5]) |> IO.puts

TailCalls.Calc.alt_mult([1,2,3,4,5]) |> IO.puts

TailCalls.Calc.fact(1000) |> IO.puts
