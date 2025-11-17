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
    GenServer.start(__MODULE__, initial_state, name: :calculator)
  end

  def sqrt() do
    GenServer.cast(:calculator, :sqrt)
  end

  def add(number) do
    GenServer.cast(:calculator, {:add, number})
  end

  def result() do
    # timeout is 5 seconds
    GenServer.call(:calculator, :result)
  end

  # Synchronous request
  def handle_call(:result, _, current_state) do
    {:reply, current_state, current_state}
  end

  def terminate(reason, current_state) do
    IO.puts("Terminated!")
    reason |> IO.inspect()
    current_state |> IO.inspect()
  end

  # Asyncronous request
  def handle_cast(:sqrt, current_state) do
    {:noreply, :math.sqrt(current_state)}
  end

  def handle_cast({:add, number}, current_state) do
    {:noreply, current_state + number}
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

{:ok, _} = GenServerModule.start(4) |> IO.inspect()
GenServerModule.sqrt() |> IO.inspect()
GenServerModule.add(10) |> IO.inspect()
GenServerModule.result() |> IO.inspect()
