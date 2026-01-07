# This file walk through defining modules, funcitons, private function, aliases, and piping the reuslts of functions to one another.

# :"Elixir.MyApp.Calc"
defmodule MyApp.Calc do
  alias IO, as: I

  def plus(a, b) do
    a + b
  end

  # def plus(a, b), do: a + b --- this is the same as the function above but on one line

  def mult(a, b) do
    do_something()
    a * b
  end

  # using def with p as a suffix makes the function private and only accessible within the module
  defp do_something do
    # length is coming from the Kernal module which is implicitly imported
    [1, 2, 3] |> length |> I.puts()
  end
end
