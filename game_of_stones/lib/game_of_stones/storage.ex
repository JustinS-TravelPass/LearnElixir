#
defmodule GameOfStones.Storage do
  @moduledoc """
  Documentation for `GameOfStones.Storage`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GameOfStones.Storage.hello()
      :world
  """

  use GenServer, restart: :transient
  @server_name __MODULE__
  @ets_name :game_of_stones_storage

  # Interface functions
  def start_link(_) do
    GenServer.start_link(@server_name, nil, name: @server_name)
  end

  def store(data) do
    IO.inspect(data)
    GenServer.call(@server_name, {:store, data})
  end

  def fetch do
    GenServer.call(@server_name, :fetch)
  end

  def fetch_all do
    GenServer.call(@server_name, :fetch_all)
  end

  # GenServer callbacks
  def init(nil) do
    :ets.new(@ets_name, [:ordered_set, :private, :named_table, {:keypos, 2}])
    {:ok, nil}
  end

  def handle_call(:fetch, _, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_call(:fetch_all, _, current_state) do
    {:reply, :ets.tab2list(@ets_name), current_state}
  end

  def handle_call({:store, {:winner, _}}, _, _state) do
    IO.inspect("Deleting ETS table...")
    :ets.delete_all_objects(@ets_name)
    {:reply, nil, nil}
  end

  def handle_call({:store, data}, _, _state) do
    :ets.insert(@ets_name, data)
    {:reply, data, data}
  end
end
