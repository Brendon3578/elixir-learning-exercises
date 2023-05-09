defmodule HighScore do
  # https://exercism.org/tracks/elixir/exercises/high-score
  @default_initial_score 0

  def new, do: %{}

  def add_player(scores, player, score \\ @default_initial_score)

  def add_player(scores, player, score), do: Map.put(scores, player, score)

  def remove_player(scores, player), do: Map.delete(scores, player)

  def reset_score(scores, player), do: Map.put(scores, player, @default_initial_score)

  def update_score(scores, player, score_to_add) do
    Map.update(scores, player, score_to_add, &(&1 + score_to_add))
  end

  def get_players(scores), do: Map.keys(scores)
end
