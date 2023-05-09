defmodule LogLevel do
  # https://exercism.org/tracks/elixir/exercises/log-level

  def to_label(level, legacy?) do
    cond do
      level == 0 && legacy? == false -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 && legacy? == false -> :fatal
      true -> :unknown
    end
  end

  def alert_recipent(level, legacy?) do
    level_label = to_label(level, legacy?)

    cond do
      level_label == :error || level_label == :fatal -> :ops
      level_label == :unknown && legacy? -> :dev1
      level_label == :unknown -> :dev2
      true -> false
    end
  end
end
