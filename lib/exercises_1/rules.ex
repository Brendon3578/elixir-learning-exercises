defmodule Rules do
  # https://exercism.org/tracks/elixir/exercises/pacman-rules

  def eat_ghost?(power_pellet_active, touching_ghost) do
    power_pellet_active && touching_ghost
  end

  def score?(touching_power_pellet, touching_dot) do
    touching_power_pellet || touching_dot
  end

  def lose?(power_pellet_active, touching_ghost) do
    touching_ghost == true and power_pellet_active == false
  end

  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost) do
    has_eaten_all_dots == true and lose?(power_pellet_active, touching_ghost) == false
  end
end
