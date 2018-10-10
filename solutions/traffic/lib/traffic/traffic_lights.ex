defmodule Traffic.TrafficLights do
  use GenServer
  @sequence [
    %{a: :red, b: :red},
    %{a: :green, b: :red},
    %{a: :red, b: :red},
    %{a: :red, b: :green}
  ]

  # Public
  def start_link(), do: start_link([])
  def start_link(state) do
    # [{:name, __MODULE__}]
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue_car(lights, car) do
    GenServer.call(__MODULE__, {:queue, lights, car})
  end

  def process_queue() do
    GenServer.cast(__MODULE__, :process_queue)
  end

  # Internal functions
  def init([]) do
    {:ok, %{a: [], b: [], sequence: @sequence, current: 0}}
  end

  def handle_call({:queue, lights, car}, from, state) do
    IO.puts "Queuing car #{car} at #{lights}"
    state = Map.update(state, lights, [], fn(q) -> q ++ [car] end)
    {:reply, state, state}
  end

  def handle_cast(:process_queue, %{sequence: sequence, current: current} = state) do
    state = process_queue(Enum.at(sequence, current), state)
    :timer.sleep(3000)
    GenServer.cast(self(), :process_queue)
    {:noreply, state}
  end

  def process_queue(%{a: :red, b: :red}, state) do
    state
  end
  def process_queue(%{a: :green, b: :red}, %{a: []} = state) do
    state
  end
  def process_queue(%{a: :green, b: :red}, %{a: [car | rest]} = state) do
    send car, {:green, :a}
    Map.put(state, :a, rest)
  end

  def process_queue(%{a: :red, b: :green}, %{b: []} = state) do
    state
  end
  def process_queue(%{a: :red, b: :green}, %{b: [car | rest]} = state) do
    send car, {:green, :b}
    Map.put(state, :b, rest)
  end
end
