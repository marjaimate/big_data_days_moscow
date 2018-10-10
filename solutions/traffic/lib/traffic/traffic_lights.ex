defmodule Traffic.TrafficLights do
  use GenServer

  # Public
  def start_link(), do: start_link([])
  def start_link(state) do
    # [{:name, __MODULE__}]
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue_car(lights, car) do
    GenServer.call(__MODULE__, {:queue, lights, car})
  end

  # Internal functions
  def init([]) do
    {:ok, %{a: [], b: []}}
  end

  def handle_call({:queue, lights, car}, from, state) do
    IO.puts "Queuing car #{car} at #{lights}"
    state = Map.update(state, lights, [], fn(q) -> q ++ [car] end)
    {:reply, state, state}
  end
end
