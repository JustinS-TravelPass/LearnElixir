# OTP Behaviors --------------------------------------------------------------
# GenServer
# Supervisor - monitor processes and restart them if they crash.
# Application - implements applications
# GenEvent - event handling support
# GenFSM - finite state machine in a server process
# All OTP Behaviors rely heavily on special callbacks.
# Each Behavior has a specific spec that the callback must adhere to.
# "init" is the only required callback.
# ----------------------------------------------------------------------------

defmodule GenServerModule do
  # Puts some code in the module for us to use within the scope of the module.
  use GenServer

  def start(initial_state) do
    GenServer.start(__MODULE__, initial_state)
  end

  # This function is called when the server is started.
  # Its a special callback function used specifically for GenServer.
  def init(initial_state) when is_number(initial_state) do
    "I am started with the state: #{initial_state}" |> IO.puts()
    {:ok, initial_state}
  end

  def init(_) do
    # The ":stop" atom is used to stop the GenServer.
    {:stop, "The initial state is not a number :("}
  end
end

{:ok, pid} = GenServerModule.start(0) |> IO.inspect()
