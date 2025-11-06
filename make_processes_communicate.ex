# Sending a message requires a PID (Process Identifier)
# When a message is sent its sent to native mailbox represented as a queue.
defmodule MakeProcessesCommunicate do
  def work do
    IO.puts("doing work...")

    # The receive is going to wait indefinitly for a message to be sent to it.
    # If a message does not match the message is put back in the mailbox.
    result = receive do
      # Here we receive the sender and the message. We then send the result of the multiplication to the sender.
      {sender, {a,b}} -> send(sender, a * b)
      # message -> "received message: #{message}"
    # Below we are telling the reciever that if no message is received after 5 seconds then we will print "no message received".
    after 5000 -> IO.puts("no message received")
    end

    IO.puts(result)
  end

  def run(message) do
    pid = spawn fn ->
      work()
    end

    # Here we pass in the PID of the current process and the message we want to send.
    send(pid, {self(),message})

    #Below we are waiting for a response from the worker process. Then we print out the message.
    receive do
      response -> IO.puts("Response: #{response}")
    end
  end
end

# MakeProcessesCommunicate.run("hello there!")

MakeProcessesCommunicate.run({2,3})
