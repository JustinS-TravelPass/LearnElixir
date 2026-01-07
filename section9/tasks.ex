# This file walks through Tasks and Agents in Elixir.

defmodule TasksAndAgents do
  def work do
    :timer.sleep(2000)
    42
  end
end

worker = Task.async(fn -> TasksAndAgents.work() end)
IO.puts("We can still do somehting else...")

answer = Task.await(worker)
IO.puts("The answer is #{answer}")
