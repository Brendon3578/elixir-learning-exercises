defmodule Calculator do
  def add(x, y) do
    x + y
  end

  def subtract(x, y) do
    private_subtract(x, y)
  end

  defp private_subtract(x, y), do: x - y
end

sum = Calculator.add(1, 2)

IO.inspect(sum)
