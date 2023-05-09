defmodule BoutiqueInventory do
  # https://exercism.org/tracks/elixir/exercises/boutique-inventory

  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      item |> Map.update!(:name, &String.replace(&1, old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    Map.update!(item, :quantity_by_size, fn value ->
      Map.new(value, fn {key, size} -> {key, size + count} end)
    end)
  end

  def total_quantity(item) do
    Map.get(item, :quantity_by_size)
    |> Enum.reduce(0, fn {_key, value}, acc -> acc + value end)
  end
end
