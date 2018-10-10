defmodule Passwords do
  def is_valid(passphrase) do
    # Option A calculate occurrence of each word
    words = String.split(passphrase, " ") # ["aa", "bb", "cc", ...]
    occurrences = List.foldl(words, Map.new, fn(word, occ) ->
                                               Map.update(occ, word, 1, fn(v) -> v + 1 end)
                                             end)
    Map.values(occurrences) |> Enum.max == 1
  end

  def is_valid_uniq(passphrase) do
    words = String.split(passphrase, " ") # ["aa", "bb", "cc", ...]
    uniq_words = Enum.uniq(words)
    length(words) == length(uniq_words)
  end

  def is_valid_set(passphrase) do
    words = String.split(passphrase, " ") # ["aa", "bb", "cc", ...]
    set = MapSet.new(words)
    length(words) == MapSet.size(set)
  end

  def is_valid_dups(passphrase) do
    words = String.split(passphrase, " ") # ["aa", "bb", "cc", ...]
    result = Enum.reduce_while(words, [], fn(word, acc) ->
      if Enum.find(acc, fn(w) -> w == word end), do: {:halt, {:duplicate, word}}, else: {:cont, acc ++ [word]}
    end)
    is_duplicate(result)
  end

  defp is_duplicate({:duplicate, word}) do
    IO.puts "found duplicate word: #{word}"
    false
  end
  defp is_duplicate(_) do
    true
  end
end
