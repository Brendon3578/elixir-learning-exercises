defmodule WineCellar do
  # https://exercism.org/tracks/elixir/exercises/wine-cellar

  @type wine_colors :: :white | :red | :rose
  @type wine_bottle :: {variety :: String.t(), year :: integer(), country :: String.t()}
  @type wines :: [{wine_colors(), wine_bottle()}]
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  @spec filter(wines :: wines(), colors :: wine_colors(), options :: keyword()) ::
          list(wine_bottle())

  def filter(cellar, color, opts \\ [])

  def filter(cellar, color, year: year) do
    filter(cellar, color, [])
    |> filter_by_year(year)
  end

  # pattern match with keywords need to be linear
  def filter(cellar, color, country: country, year: year) do
    filter(cellar, color, year: year, country: country)
  end

  def filter(cellar, color, year: year, country: country) do
    filter(cellar, color, year: year)
    |> filter_by_country(country)
  end

  def filter(cellar, color, country: country) do
    filter(cellar, color, [])
    |> filter_by_country(country)
  end

  def filter(cellar, color, _opts), do: Keyword.get_values(cellar, color)

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
