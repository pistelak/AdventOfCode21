defmodule AdventOfCode do

  def process_file(file_name) do

    lines = File.read!(file_name)
      |> String.split("\n")

    numbers_to_play = lines
      |> Enum.at(0)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    boards = lines
      |> Enum.drop(1)
      |> Enum.chunk_by(&(&1 == ""))
      |> Enum.filter(&(length(&1) > 1))
      |> Enum.map(&process_input/1)

    evaluate(boards, [], numbers_to_play)

  end

  @doc """
   iex>[[
   ...> [14, 21, 17, 24,  4],
   ...> [10, 16, 15,  9, 19],
   ...> [18,  8, 23, 26, 20],
   ...> [22, 11, 13,  6,  5],
   ...> [ 2,  0, 12,  3,  7]
   ...>]] |> AdventOfCode.evaluate([], [7, 4, 9, 5, 11, 17, 23, 2, 0 , 14, 21, 24])
   4512
  """
  def evaluate(boards, played_numbers, [drawn | numbers_to_play]) do

    played_numbers = played_numbers ++ [drawn]

    bingo = boards
      |> Enum.find(& &1 |> mark_numbers(played_numbers) |> bingo_on_board?)

    if bingo != nil,
    do: bingo |> mark_numbers(played_numbers) |> sum_of_all_unmarked_numbers |> then(&(&1 * drawn)),
    else: evaluate(boards, played_numbers, numbers_to_play)

  end

  @doc """
    Returns board but all played numbers are marked (-1)

    iex> [[1, 2, 3], [3, 2, 1], [2, 1, 3]] |> AdventOfCode.mark_numbers([1, 2])
    [[-1, -1, 3], [3, -1, -1], [-1, -1, 3]]
  """
  def mark_numbers(board, played_numbers) do
    board
      |> Enum.map(&mark_numbers_in_row(&1, played_numbers))
  end

  @doc """
    Returns board but all played numbers are marked (-1)

    iex> [1, 2, 3] |> AdventOfCode.mark_numbers_in_row([1, 2])
    [-1, -1, 3]
  """
  def mark_numbers_in_row(row, played_numbers) do
    row
      |> Enum.map(fn element -> if Enum.member?(played_numbers, element), do: -1, else: element end)
  end

  @doc """
    Returns true if numbers either in row or column are marked (-1)

    iex> [[-1, 1], [-1, -1]] |> AdventOfCode.bingo_on_board?
    true
    iex> [[-1, 2], [-1, 2]] |> AdventOfCode.bingo_on_board?
    true
    iex> [[-1, 1], [1, -1]] |> AdventOfCode.bingo_on_board?
    false
  """
  def bingo_on_board?(board) do

    bingo_in_row = board |> Enum.map(&bingo_in_row?/1) |> Enum.reduce(&or/2)
    bingo_in_column = board |> transpose |> Enum.map(&bingo_in_row?/1) |> Enum.reduce(&or/2)

    bingo_in_row or bingo_in_column
  end

  @doc """
    Returns true if all numbers in row are marked (-1)

    iex> [-1, -1, -1] |> AdventOfCode.bingo_in_row?
    true
    iex> [-1, 2, -1] |> AdventOfCode.bingo_in_row?
    false
  """
  def bingo_in_row?(row) do
    Enum.all?(row, &(&1 == -1))
  end

  @doc """
    iex> [[1, 2, 3], [3, 2, 1], [2, 1, 3]] |> AdventOfCode.transpose
    [[1, 3, 2], [2, 2, 1], [3, 1, 3]]
  """
  def transpose(board) do
    board
      |> Enum.zip
      |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
    iex> [[-1, -1, 1], [-1, -1, -1]] |> AdventOfCode.sum_of_all_unmarked_numbers
    1
  """
  def sum_of_all_unmarked_numbers(board) do
    board
      |> List.flatten
      |> Enum.filter(&(&1 > 0))
      |> Enum.sum
  end

  def process_input(strings) do

    strings
      |> Enum.map(fn line -> String.split(line, " ", trim: true) end)
      |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
  end

end
