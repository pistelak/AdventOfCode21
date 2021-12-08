defmodule AdventOfCode do

  def process_file(file_name) do

    File.read!(file_name)
      |> String.split(",", trim: true )
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies
      |> then(fn frequencies -> Enum.map((0..8), fn i -> frequencies |> Map.get(i, 0) end) end)
      |> simulate(80)
  end

  @doc """
  iex> AdventOfCode.simulate([3,4,3,1,2], 18)
  26
  """
  def simulate(sample, number_of_steps) do
    (1..number_of_steps)
      |> Enum.reduce(sample, fn _, sample -> step(sample) end)
      |> Enum.sum()
  end

  def step([a, b, c, d, e, f, g, h, i]) do
    [b, c, d, e, f, g, h + a, i, a]
  end

end
