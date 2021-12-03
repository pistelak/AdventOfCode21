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
      |> most_common_elements

      gamma = gamma_rate(result)
      epsilon = epsilon_rate(result)

      gamma * epsilon
  end

  @doc """
    iex> ["00100","11110","10110","10111","10101","01111","00111","11100","10000","11001","00010","01010"]
    ...> |> AdventOfCode.find_life_support_rating()
    230
  """
  def find_life_support_rating(list) do
    find_oxygen_generator_rating(list) * find_co2_scrubber_rating(list)
  end

  @doc """
    iex> ["00100","11110","10110","10111","10101","01111","00111","11100","10000","11001","00010","01010"]
    ...> |> AdventOfCode.find_oxygen_generator_rating()
    23
  """
  def find_oxygen_generator_rating(list) do

    list
      |> Enum.map(&AdventOfCode.array_of_digits/1)
      |> reduce(0, &AdventOfCode.most_common_elements/1)
      |> bits_to_integer()

  end

  @doc """
    iex> ["00100","11110","10110","10111","10101","01111","00111","11100","10000","11001","00010","01010"]
    ...> |> AdventOfCode.find_co2_scrubber_rating()
    10
  """
  def find_co2_scrubber_rating(list) do

    list
      |> Enum.map(&AdventOfCode.array_of_digits/1)
      |> reduce(0, &AdventOfCode.least_common_elements/1)
      |> bits_to_integer()

  end

  @doc """
    iex> [[1, 1, 0, 0], [0, 0, 1, 1], [0, 1, 1, 0]] |> AdventOfCode.reduce(0, &AdventOfCode.most_common_elements/1)
    [0, 1, 1, 0]
  """
  def reduce([head], _current_bit_position, _comparator) do
    head
  end

  def reduce(array, current_bit_position, comparator) do

    most_common_element = array
      |> transpose
      |> comparator.()
      |> Enum.at(current_bit_position)

    filteredArray = filter(array, most_common_element, current_bit_position)

    reduce(filteredArray, current_bit_position + 1, comparator)

  end

  @doc """
  iex> AdventOfCode.filter([[0, 0], [1, 0], [0, 1]], 0, 0)
  [[0,0], [0, 1]]
  """
  def filter(array, given_element, index) do
    array
      |> Enum.filter(fn element -> Enum.at(element, index) == given_element end)
  end

  @doc """
  iex> AdventOfCode.most_common_elements([[0, 1, 1], [0, 1, 0]])
  [1, 0]
  iex> AdventOfCode.most_common_elements([[0, 1], [0, 1]])
  [1, 1]
  """
  def most_common_elements(array) do
    array
      |> Enum.map(&Enum.frequencies/1)
      |> Enum.map(fn f -> Enum.max_by(f, &elem(&1, 1), &>/2) end)
      |> Enum.map(&elem(&1, 0))
  end

  @doc """
  iex> AdventOfCode.least_common_elements([[0, 1, 1], [0, 1, 0]])
  [0, 1]
  iex> AdventOfCode.least_common_elements([[0, 1], [0, 1]])
  [0, 0]
  """
  def least_common_elements(array) do
    array
      |> Enum.map(&Enum.frequencies/1)
      |> Enum.map(fn f -> Enum.min_by(f, &elem(&1, 1)) end)
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
      |> bits_to_integer()
  end

  @doc """
    iex> AdventOfCode.epsilon_rate([1, 0, 0, 1])
    6
  """
  def epsilon_rate(bits) do
    bits
      |> Enum.map(fn x -> if x == 0, do: 1, else: 0 end)
      |> bits_to_integer()
  end

  defp bits_to_integer(bits) do
    bits
      |> Enum.join
      |> String.to_integer(2)
  end
end
