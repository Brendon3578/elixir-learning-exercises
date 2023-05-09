defmodule Lasagna do
  # https://exercism.org/tracks/elixir/exercises/lasagna

  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(actual_minutes) do
    expected_minutes_in_oven() - actual_minutes
  end

  def preparation_time_in_minutes(lasagna_layers) do
    2 * lasagna_layers
  end

  def total_time_in_minutes(layers, minutes_in_oven) do
    preparation_time_in_minutes(layers) +
      minutes_in_oven
  end

  def alarm, do: "Ding!"
end
