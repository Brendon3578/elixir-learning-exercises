defmodule BirdCount do
  # https://exercism.org/tracks/elixir/exercises/bird-count

  def today([]), do: nil
  def today([today | _others_day]), do: today

  def increment_day_count([]), do: [1]

  def increment_day_count([today | others_days]), do: [today + 1 | others_days]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?(daily_birds), do: 0 in daily_birds

  def total([]), do: 0
  def total([today | others_days]), do: today + total(others_days)

  def busy_days([]), do: 0

  def busy_days([today | others_days]) do
    cond do
      today >= 5 -> 1 + busy_days(others_days)
      true -> busy_days(others_days)
    end
  end
end
