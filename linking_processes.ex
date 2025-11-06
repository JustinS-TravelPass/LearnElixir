defmodule LinkingProcesses do
  def work do
    IO.puts("working...")
    exit :error
  end

  def run do
    # This flag will trap the exit signal and print the exit reason.
    # This prevents the linked process from exiting and killing the current process allowing you to handle the exit signal.
    Process.flag(:trap_exit, true)

    # Using "spawn_link" will link the current process to the new process.
    # If the new process exits with an error, the current process will also exit with an error.
    spawn_link fn -> work() end

    receive do
      response -> IO.inspect(response)
    end

    IO.puts("doing something else...")
  end
end

LinkingProcesses.run()
