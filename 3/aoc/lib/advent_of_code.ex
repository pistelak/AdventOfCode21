defmodule AdventOfCode do

  def process_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
      |> process_list
  end

  @doc """
    iex> ["00100","11110","10110","10111","10101","01111","00111","11100","10000","11001","00010","01010"]
    ...> |> AdventOfCode.process_list()
    198
  """
  def process_list(list) do
    result = list
      |> Enum.map(&AdventOfCode.array_of_digits/1)
      |> transpose
      |> most_common_element

      gamma = gamma_rate(result)
      epsilon = epsilon_rate(result)

      gamma * epsilon
  end

  @doc """
  iex> AdventOfCode.most_common_element([[0, 1, 1], [0, 1, 0]])
  [1, 0]
  """
  def most_common_element(array) do
    array
      |> Enum.map(&Enum.frequencies/1)
      |> Enum.map(fn f -> Enum.max_by(f, &elem(&1, 1)) end)
      |> Enum.map(&elem(&1, 0))
  end

  @doc """
    iex> AdventOfCode.transpose([[0, 0, 1, 1], [0, 1, 0, 1]])
    [[0, 0], [0, 1], [1, 0], [1, 1]]
  """
  def transpose(matrix) do
    matrix
      |> Enum.zip
      |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
    iex> AdventOfCode.array_of_digits("0011")
    [0, 0, 1, 1]
  """
  def array_of_digits(string) do
    string
      |> String.graphemes
      |> Enum.map(&String.to_integer/1)
  end

  @doc """
    iex> AdventOfCode.gamma_rate([1, 0, 0, 1])
    9
  """
  def gamma_rate(bits) do
    bits
      |> Enum.join
      |> String.to_integer(2)
  end

  @doc """
    iex> AdventOfCode.epsilon_rate([1, 0, 0, 1])
    6
  """
  def epsilon_rate(bits) do
    bits
      |> Enum.map(fn x -> if x == 0, do: 1, else: 0 end)
      |> Enum.join
      |> String.to_integer(2)
  end
end
