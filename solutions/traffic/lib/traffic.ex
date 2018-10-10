defmodule Traffic do
  def generate(n) do
    gen_cars(n)
    Traffic.TrafficLights.process_queue
  end

  def gen_cars(0), do: :ok
  def gen_cars(n) do
    # spawn some cars here
    car = spawn Traffic.Car, :start, []
    # we need some random stuff here
    lights = [:a, :b] |> Enum.random
    Traffic.TrafficLights.queue_car lights, car
    gen_cars(n-1)
  end
end
