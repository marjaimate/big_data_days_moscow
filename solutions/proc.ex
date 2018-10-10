defmodule Proc do
  def listen do
    receive do
      "hello" -> IO.puts("*waves*")
      "hi" ->
        IO.puts("hi")
        listen
    after
      3000 ->
        IO.puts("yawn")
        listen
    end
  end
end
