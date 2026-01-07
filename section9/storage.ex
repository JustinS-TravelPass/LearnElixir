# The anon functions you pass to Agents run inside of the Agent. Sometime it may be better to run it outside of the Agent.

defmodule Storage do
  @name {:global, :storage}

  def start_link do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def store(result, number) do
    Agent.update(@name, fn state -> Map.merge(state, %{number => result}) end)
  end

  def factorials do
    Agent.get(@name, fn state -> state end)
  end

  def factorial_of(number) do
    Map.get(factorials(), number)
  end
end

defmodule FactorialProducer do
  # enum
  def products_of(numbers) do
    numbers
    |> Stream.map(fn number -> Task.async(fn -> fact(number) end) end)
    |> Enum.map(&Task.await/1)
  end

  def fact(number) do
    do_fact(1, number) |> Storage.store(number)
  end

  defp do_fact(result, 0), do: result

  defp do_fact(result, a) do
    (result * a) |> do_fact(a - 1)
  end
end

# Storage.start_link()
# FactorialProducer.products_of(1..10)
# Storage.factorials() |> IO.inspect()
# Storage.factorial_of(10) |> IO.inspect()

# A cool exercise to do is to create two nodes.
# Connect them using Node.connect
# Setup the storage link on the first node.
# Then run 'FactorialProducer.products_of(1..10)' on the fisrt node.
# Then run 'Storage.factorials()' on the second node.
# You should see the same results on both nodes.
# This demonstrates that the data is shared between the nodes.
