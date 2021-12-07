defmodule AdventOfCode do

  def process_file(file_name) do

    sequence = File.read!(file_name)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    number_of_moves(sequence, median(sequence))

  end

  def number_of_moves(list, median) do
    list |> Enum.map(&abs(&1 - median)) |> Enum.sum
  end

  def median(list) do
    list |> Enum.sort |> Enum.at(div(length(list), 2))
  end

end
