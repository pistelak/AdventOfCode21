defmodule AdventOfCode do

  def process_file(file_name) do

    File.read!(file_name)
      |> String.split("\n", trim: true)
      |> process_lines
  end

  @doc """
  iex> [
  ...> "0,9 -> 5,9",
  ...> "8,0 -> 0,8",
  ...> "9,4 -> 3,4",
  ...> "2,2 -> 2,1",
  ...> "7,0 -> 7,4",
  ...> "6,4 -> 2,0",
  ...> "0,9 -> 2,9",
  ...> "3,4 -> 1,4",
  ...> "0,0 -> 8,8",
  ...> "5,5 -> 8,2"
  ...> ] |> AdventOfCode.process_lines
  12
  """
  def process_lines(lines) do

    lines
      |> Enum.map(&parse_line/1)
      |> Enum.flat_map(&generate_line/1)
      |> Enum.frequencies
      |> Enum.filter(&(elem(&1, 1)) >= 2)
      |> Enum.count
  end

  @doc """
  iex> [[0, 9], [0, 2]] |> AdventOfCode.generate_line
  [[0, 9], [0, 8], [0, 7], [0, 6], [0, 5], [0, 4], [0, 3], [0, 2]]
  iex> [[0, 2], [5, 2]] |> AdventOfCode.generate_line
  [[0, 2], [1, 2], [2, 2], [3, 2], [4, 2], [5, 2]]
  iex> [[0, 0], [3, 3]] |> AdventOfCode.generate_line
  [[0, 0], [1, 1], [2, 2], [3, 3]]
  """
  def generate_line([[x1, y], [x2, y]]) do
    x1..x2 |> Enum.to_list |> Enum.map(&([&1, y]))
  end

  def generate_line([[x, y1], [x, y2]]) do
    y1..y2 |> Enum.to_list |> Enum.map(&([x, &1]))
  end

  def generate_line([[x1, y1], [x2, y2]]) do
    x_coords = x1..x2 |> Enum.to_list
    y_coords = y1..y2 |> Enum.to_list

    Enum.zip(x_coords, y_coords)
      |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  iex> "0,9 -> 5,9" |> AdventOfCode.parse_line
  [[0, 9], [5, 9]]
  """
  def parse_line(line) do
    line |> String.split([" -> ", ","], trim: true) |> Enum.map(&String.to_integer/1) |> Enum.chunk_every(2)
  end

end
