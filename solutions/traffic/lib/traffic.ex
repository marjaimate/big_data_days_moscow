defmodule Traffic do
  def generate(n) do
    Traffic.TrafficLights.process_queue
    gen_cars(n)
  end

  def gen_cars(0), do: :ok
  def gen_cars(n) do
    # spawn some cars here
    car = spawn Traffic.Car, :start, []
    # we need some random stuff here
    Traffic.TrafficLights.queue_car :a, car
    gen_cars(n-1)
  end
end
