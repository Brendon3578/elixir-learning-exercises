defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)
  
  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """

  def generate(number) when not is_integer(number) or number < 1 do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end

  def generate(1), do: [2]
  def generate(2), do: [2, 1]

  def generate(number) when number > 2 do
    Stream.iterate({2, 1}, fn {x, y} -> {y, x + y} end)
    |> Enum.take(number)
    |> Enum.map(fn {x, _} -> x end)
  end
end
