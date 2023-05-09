defmodule NameBadge do
  # https://exercism.org/tracks/elixir/exercises/name-badge

  @owner_department "owner"
  @separator " - "

  def print(id, name, department) do
    id_str = if id, do: "[#{id}]" <> @separator, else: ""
    dpt_str = if department, do: department, else: @owner_department

    id_str <> name <> @separator <> String.upcase(dpt_str)
  end
end
