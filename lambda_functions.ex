# This creates a lambda function with an Arity of /1
mad_printer_one = fn(initial_string) ->
  initial_string |>
  String.reverse |>
  IO.puts
end
["hello-1", "world-1", "justin-1"] |> Enum.each(mad_printer_one)

salt = "random"

#This syntax is great for very small lambdas
mad_printer_two = &(
  &1 <> salt |>
  String.reverse |>
  IO.puts
)

["hello-2", "world-2", "justin-2"] |> Enum.each(mad_printer_two)
# mad_printer.("Hello, World!")

#This is some syntactic sugar you can use to call a function with a single argument.
# The '&' is a capture operator. It captures the function and passes it as an argument to the Enum.each function.
Enum.each(["hello", "world", "justin"], &IO.puts/1)

# This version of a lambda allows you to define two function bodies
# You can have as many bodies as you want, but you must have at least one.
mad_printer_three = fn
  ("") -> IO.puts("__NOVAL__")
  (initial_string) ->
    initial_string <> salt |>
    String.reverse |>
    IO.puts
end

["hello-3", "world-3", "justin-3"] |> Enum.each(mad_printer_three)
