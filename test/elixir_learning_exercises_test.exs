defmodule ElixirLearningExercisesTest do
  use ExUnit.Case
  doctest ElixirLearningExercises

  test "greets the world" do
    assert ElixirLearningExercises.hello() == :world
  end
end
