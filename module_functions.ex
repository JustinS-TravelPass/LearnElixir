defmodule MyApp.Calc do # :"Elixir.MyApp.Calc"
  alias IO, as: I

  def plus(a, b) do
    a + b
  end

  # def plus(a, b), do: a + b --- this is the same as the function above but on one line

  def mult(a, b) do
    do_something()
    a * b
  end

  defp do_something do # using def with p as a suffix makes the function private and only accessible within the module
    [1,2,3] |> length |> I.puts #length is comig from the kernal module which is implicitly imported
  end
end
