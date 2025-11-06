defmodule MonitoringProcesses do
  def work do
    IO.puts("working...")
    exit :error
  end

  def run do
    # This will spawn a new process and monitor it. This connection is unilateral (one way). So the new process can not monitor the current process.
    # Because the processes are not linked, the current process will not exit when the new process exits. Instead the current process will receive a message from the new process saying that it exited.
    pid = spawn fn -> work() end
    Process.monitor(pid)

    # Below is another way to spawn a new process and monitor it with the same result as above.
    # spawn_monitor(MonitoringProcesses, :work, [])

    receive do
      msg -> IO.inspect(msg)
    end
  end
end

MonitoringProcesses.run()
