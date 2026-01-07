# Macros are special forms that return quoted code.
# Macros are processed at compile time, before the program is executed.

defmodule Demo do
  defmacro work(arguments) do
    quote do
      unquote(arguments) * 10
    end
  end

  defmacro macro_palidrome?(str, expr) do
    quote do
      if unquote(str) == String.reverse(unquote(str)), do: unquote(expr)
    end
  end

  def palidrome?(str, expr) do
    if str == String.reverse(str), do: expr
  end
end

defmodule Playground do
  require Demo

  def test!(str) do
    # Demo.work(2) |> IO.inspect()
    Demo.macro_palidrome?(str, IO.puts("'#{str}' Is a palidrome!"))
  end
end

Playground.test!("racecar")
