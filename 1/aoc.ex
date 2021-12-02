defmodule AdventOfCode do
  def process_file(file_name) do
    File.read!(file_name)
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> AdventOfCode.compute(0)
  end

  def compute([left, right | tail], accumulator) when left < right do
    compute([right | tail], accumulator + 1)
  end

  def compute([_left, right | tail], accumulator) do
    compute([right | tail], accumulator)
  end

  def compute([_], accumulator) do
    accumulator
  end
end
