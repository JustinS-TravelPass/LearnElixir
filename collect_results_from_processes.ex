defmodule CollectResultsFromProcesses do
  def work do
    # Spawn a new process
    spawn fn ->
      # Use the receive function so that the process knows it can receive messages.
      # When a message is received, pattern match the payload, wait 5 seconds, then send the result back to the sender process.
      receive do
        # Pattern match the payload to get the sender and the number.
        {sender, num} ->
          # Sleep for 5 seconds
          :timer.sleep(5000)
          # "send" is from the Kernel module which is implicitly imported. Use this function to send a message to the sender process.
          send(sender, num * :rand.uniform())
      end
    end
  end

  # Created 5 processes that will each send a message to the work processes.
  def run do
    1..5 |> Enum.each(fn(i) ->
      pid = work()
      # "self" refers to the current process that is sending the message to the work process. The function returns the PID of the process.
      send(pid, {self(), i})
    end)

    # We now spawn 5 processes that will each receive a message from a work process.
    # The map will return all the responses in a list.
    1..5 |> Enum.map(fn(_) -> response() end)
  end

  defp response do
    receive do
      result -> result
    end
  end
end

CollectResultsFromProcesses.run() |> IO.inspect
