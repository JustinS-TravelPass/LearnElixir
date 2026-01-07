# Create an Agent that starts with the state 42.
{:ok, pid} = Agent.start(fn -> 42 end)

# Get the state of the Agent.
Agent.get(pid, fn state -> state end) |> IO.puts()

# Update the state of the Agent, multiply the state by 2, then get the state of the Agent.
Agent.update(pid, fn state -> state * 2 end)
Agent.get(pid, fn state -> state end) |> IO.puts()
