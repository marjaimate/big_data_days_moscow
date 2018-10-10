defmodule Traffic.Car do
  def start do
    receive do
      {:green, lights} ->
        IO.puts "#{inspect self()} moving through [#{lights}]"
    after
      5000 ->
        IO.puts "#{inspect self()} still waiting..."
        start()
    end
  end
end
