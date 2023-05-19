defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_item, character), do: {nil, Map.update!(character, :health, &(&1 + 5))}
  end

  defimpl Edible, for: ManaPotion do
    def eat(item, character) do
      {%EmptyBottle{}, Map.update!(character, :mana, &(&1 + item.strength))}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_item, character), do: {%EmptyBottle{}, %{character | health: 0}}
  end
end
