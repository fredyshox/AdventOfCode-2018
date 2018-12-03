#!/usr/bin/env elixir
#
# part1.exs
# Copyright(c) 2018 Kacper Rączy
#

if length(System.argv) < 1 do
  IO.puts(:stderr, "Usage: script_name input_file")
  exit(1)
end

filename = List.first(System.argv)
fstream = File.stream!(filename)

line_handler = fn str ->
  :binary.bin_to_list(str)
  |> Enum.reduce(%{}, fn char, acc ->
    val = (if acc[char], do: acc[char] + 1, else: 1)
    Map.put(acc, char, val)
  end)
  |> Enum.filter(fn {_key, value} -> value == 2 or value == 3 end)
  |> Enum.reduce_while({0, 0}, fn {_key, value}, {c2, c3} ->
    case {value, c2, c3} do
      {2, x, _} when x < 1 -> {:cont, {x + 1, c3}}
      {3, _, y} when y < 1 -> {:cont, {c2, y + 1}}
      # already found sufficient x&y
      {_, x, y} when x > 0 and y > 0 -> {:halt, {x, y}}
      # found 2/3 again
      _ -> {:cont, {c2, c3}}
    end
  end)
end

{c2, c3} =
  fstream
  |> Enum.map( &(String.trim_trailing(&1)) )
  |> Enum.reduce({0, 0}, fn line, {c2, c3} ->
    {t2, t3} = line_handler.(line)
    {c2 + t2, c3 + t3}
  end)

checksum = c2 * c3
IO.puts("Checksum: #{checksum} = #{c2} * #{c3}")
