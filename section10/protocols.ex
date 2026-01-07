# Achieve polymorphism by using protocols.

defprotocol DemoProtocol do
  def work(argument)
end

defimpl DemoProtocol, for: Integer do
  def work(argument) do
    (argument * 10) |> IO.inspect()
  end
end

defimpl Enumerable, for: Integer do
  def count(_argument) do
    1
  end
end

DemoProtocol.work(10)
Enumerable.count(10) |> IO.inspect()
