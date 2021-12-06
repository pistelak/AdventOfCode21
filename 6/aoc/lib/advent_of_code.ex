defmodule AdventOfCode do

  def process_file(file_name) do

    File.read!(file_name)
      |> String.split(",", trim: true )
      |> Enum.map(&String.to_integer/1)
      |> simulate(80)

  end

  @doc """
  iex> AdventOfCode.simulate([3,4,3,1,2], 18)
  26
  """
  def simulate(fishes, 0) do
    fishes |> Enum.count
  end

  def simulate(fishes, number_of_iteration_left) do

    number_of_fishes_to_add = Enum.count(fishes, &(&1 == 0))

    fishes = Enum.map(fishes, fn until_new_fish -> if until_new_fish == 0, do: 6, else: until_new_fish - 1 end)
    fishes = [fishes | List.duplicate(8, number_of_fishes_to_add)] |> List.flatten

    simulate(fishes, number_of_iteration_left - 1)
  end

end
