defmodule AdventOfCode do

  def process_file(file_name) do

    sequence = File.read!(file_name)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> number_of_moves

  end

  def number_of_moves(list) do
    min = list |> Enum.min
    max = list |> Enum.max

    min..max
      |> Enum.map(fn destination ->
        list |> Enum.map(&cost(&1, destination)) |> Enum.sum
      end)
      |> Enum.min
  end

  def cost(initial_position, destination) do
    n = abs(initial_position - destination)
    n * (n + 1) / 2
  end

end
