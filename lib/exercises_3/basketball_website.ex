defmodule BasketballWebsite do
  def extract_from_path(data, path), do: access_map(data, keys(path))

  defp access_map(map, []), do: map
  defp access_map(map, [key | others_keys]), do: map[key] |> access_map(others_keys)

  def get_in_path(data, path), do: get_in(data, keys(path))

  defp keys(path), do: String.split(path, ".", trim: true)
end
