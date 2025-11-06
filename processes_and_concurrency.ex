defmodule Concurrency do
  def work(number, index) do
    # Processes can be returned at different times.
    pid = spawn fn ->
      :timer.sleep(5000)
      IO.puts("#{index}: Result is #{:rand.normal() * number}")
    end

    pid |> IO.inspect
  end

  def run(number) do
    Enum.each(1..5, &(work(number, &1)))
  end
end

# pid = spawn Concurrency, :work, []
Concurrency.run(5)
IO.puts("do some other stuff")
