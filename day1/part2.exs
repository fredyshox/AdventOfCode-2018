#!/usr/bin/env elixir
#
# part2.exs
# Copyright(c) 2018 Kacper Rączy
#

defmodule DuplicateSeeker do

  # frickin while loop
  def find_duplicate(ints, acc \\ 0, fset \\ MapSet.new([0])) do
    case fd_handler(ints, acc, fset) do
      {:notfound, new_acc, new_fset} ->
        find_duplicate(ints, new_acc, new_fset)
      {:found, new_acc, _} ->
        new_acc
    end
  end

  defp fd_handler([], acc, fset), do: {:notfound, acc, fset}
  defp fd_handler([int | rest], acc, fset) do
    new_acc = acc + int
    if MapSet.member?(fset, new_acc) do
      {:found, new_acc, fset}
    else
      fset = MapSet.put(fset, new_acc)
      fd_handler(rest, new_acc, fset)
    end
  end

end

if length(System.argv) < 1 do
  IO.puts(:stderr, "Usage: script_name input_file")
  exit(1)
end

filename = List.first(System.argv)
lines =
  File.read!(filename)
  |> String.trim_trailing
  |> String.split("\n")
  |> Enum.map(fn str -> elem(Integer.parse(str), 0) end)

duplicate = DuplicateSeeker.find_duplicate(lines)
IO.puts("Duplicate: #{duplicate}")
