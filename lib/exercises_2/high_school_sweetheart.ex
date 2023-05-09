defmodule HighSchoolSweetheart do
  # https://exercism.org/tracks/elixir/exercises/high-school-sweetheart

  def first_letter(name), do: name |> String.trim() |> String.first()
  def initial(name), do: name |> first_letter() |> String.upcase() |> Kernel.<>(".")

  def initials(full_name) do
    [first_name, last_name] = String.split(full_name)
    "#{initial(first_name)} #{initial(last_name)}"
  end

  def pair(full_name, second_full_name) do
    p1 = initials(full_name)
    p2 = initials(second_full_name)

    "     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     #{p1}  +  #{p2}     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
  end
end
