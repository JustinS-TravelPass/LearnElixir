defmodule Comp do
  require Integer

  def format_data(data) do
    for {name, age} <- data, into: Map.new,
    do: {format_name(name), age}
  end

  def format_name(name) do
    name |> String.downcase |> String.to_atom
  end

  def demo(list) do
    # The el <- list is a generator. The statement as a whole is a comprehension.
    for el when el < 10 <- list, Integer.is_even(el), do: el * 2
  end

  def demo2(list1, list2) do
    for el1 <- list1, el2 <- list2, Integer.is_even(el1), Integer.is_even(el2),
    do: {el1, el2}
  end

  def decipher(cipher_string) do
    # Below demonstrates using binary strings in comprehensions. We take in a cipher string and do a ceaser cipher shift of 1.
    for <<char <- cipher_string>>, do: char - 1
  end
end

Comp.decipher("fmjyjs") |> IO.inspect

Comp.demo(1..10) |> IO.inspect

Comp.demo2(1..5, 6..10) |> IO.inspect

data = %{"Joe" => 50, "Jane" => 20, "Jim" => 30}
Comp.format_data(data) |> IO.inspect
