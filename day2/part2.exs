#!/usr/bin/env elixir
#
# part2.exs
# Copyright(c) 2018 Kacper Rączy
#

if length(System.argv) < 1 do
  IO.puts(:stderr, "Usage: script_name input_file")
  exit(1)
end

filename = List.first(System.argv)
fstream = File.stream!(filename)

# takes 2 strings converted to byte lists
# we know they have the same size
# O(length(str1)) running time
string_handler = fn str1, str2 ->
  Enum.zip(str1, str2)
  |> Enum.reduce_while(0, fn {chr1, chr2}, acc ->
    cond do
      chr1 != chr2 and acc == 0 -> {:cont, acc + 1}
      chr1 != chr2 and acc > 0 -> {:halt, acc + 1}
      true -> {:cont, acc}
    end
  end)
end

# O(n^2) running time
line_handler = fn lists ->
  Enum.zip(0..length(lists) - 1, lists)
  |> Enum.any?(fn {start, list} ->
    last_idx = length(list) - 1
    result =
      Enum.reduce_while(start+1..last_idx, :notfound, fn index, acc ->
        case string_handler.(list, Enum.at(lists, index)) do
          x when x == 1 -> {:halt, index}
          _ -> {:cont, acc}
        end
      end)
    if result != :notfound do
      [eq: p1, del: _, ins: _, eq: p2] = List.myers_difference(list, Enum.at(lists, result))
      IO.puts("result: \n\t#{list}\n\t#{Enum.at(lists, result)}")
      IO.puts("common part: \n\t#{p1}#{p2}")
    end
    result != :notfound
  end)
end

fstream
|> Enum.map(fn binstr ->
  trimmed = String.trim_trailing(binstr)
  :binary.bin_to_list(trimmed)
end)
|> line_handler.()
