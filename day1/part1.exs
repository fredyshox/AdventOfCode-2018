#!/usr/bin/env elixir
#
# part1.exs
# Copyright(c) 2018 Kacper Rączy
#

result =
  IO.stream(:stdio, :line)
  |> Enum.reduce(0, fn data, acc ->
    {value, _} = Integer.parse(data)
    acc + value
  end)

IO.puts("Result: #{result}")
