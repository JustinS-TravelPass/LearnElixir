defmodule Conditional do
  require Integer

  def run(val) do
    if Integer.is_even(val), do: "positive", else: "negative"
  end

  def run2(val) do
    #if checks if the condition is truthy
    if val == 5 do
      "the value is 5"
    else
      "the value is not 5"
    end
  end

  def run3(val) do
    # unless checks if the condition is falsy
    unless val == 5 do
      "the value is not 5"
    else
      "the value is 5"
    end
  end

  def run4(str) do
    len = String.length(str)

    # Cond works like a switch statement in other languages.
    # The condiditons that truthy first will be returned.
    # If none of the conditions are truthy then the last condition will be returned since its always true. Its like our default in switch statements.
    cond do
      len > 0 && len < 5 -> "short"
      len >= 5 && len < 10 -> "medium"
      len > 10 -> "long"
      true -> "an empty string"
    end
  end

  def run5(argv) do
    parsed_args = OptionParser.parse(argv, switches: [debug: :boolean])

    #elem comes from the Kernel module. Which is implicity imported.
    case  Keyword.fetch(elem(parsed_args, 0), :debug) do
      {:ok, true} -> "debug mode"
      {:ok, false} -> "normal mode"
      _ -> "no debug flag"
    end
  end
end

Conditional.run(5) |> IO.inspect

Conditional.run2(5) |> IO.inspect

Conditional.run3(6) |> IO.inspect

Conditional.run4("hello there!") |> IO.inspect

# Use this command: "iex conditional_logic.ex --debug=true" to test the below function.
Conditional.run5(System.argv) |> IO.inspect
