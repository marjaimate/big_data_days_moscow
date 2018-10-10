defmodule Runlength do
  def encode(str) do
    [current_ch | chars] = String.graphemes(str)
    encode(chars, current_ch, 1, "")
  end

  # We reached the end - return the encoded result
  # this is the same as the end of a foreach loop,
  # essentially we ran out of elements to process
  def encode([], current_ch, count, result) do
    result <> Integer.to_string(count) <> current_ch #  i.e. "..3A"
  end

  # Process the list and compare the next character
  # with the current character
  def encode([current_ch | rest], current_ch, count, result) do
    encode(rest, current_ch, count + 1, result)
  end

  def encode([next | rest], current_ch, count, result) do
    encode(rest, next, 1, result <> Integer.to_string(count) <> current_ch)
  end

  def encode_str(<<current_ch :: binary-size(1), chars :: binary>>) do
    encode_str(chars, current_ch, 1, "")
  end

  def encode_str(<<>>, current_ch, count, result) do
    # result <> Integer.to_string(count) <> current_ch #  i.e. "..3A"
    <<result :: binary, (Integer.to_string(count)) :: binary, current_ch ::binary>>
  end

  def encode_str(<< current_ch :: binary-size(1), chars :: binary>>, current_ch, count, result) do
    encode_str(chars, current_ch, count + 1, result)
  end

  def encode_str(<< next :: binary-size(1), chars :: binary>>, current_ch, count, result) do
    encode_str(chars, next, 1, result <> Integer.to_string(count) <> current_ch)
  end
end
