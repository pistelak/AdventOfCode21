defmodule AdventOfCode do

  def process_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
      |> compute(0, 0)
  end

  def compute(["forward " <> rest | tail], horizontal_position, depth) do
    value = String.to_integer(rest)
    compute(tail, horizontal_position + value, depth)
  end

  def compute(["up " <> rest | tail], horizontal_position, depth) do
    value = String.to_integer(rest)
    compute(tail, horizontal_position, depth - value)
  end

  def compute(["down " <> rest | tail], horizontal_position, depth) do
    value = String.to_integer(rest)
    compute(tail, horizontal_position, depth + value)
  end

  def compute([], horizontal_position, depth) do
    horizontal_position * depth
  end

end
