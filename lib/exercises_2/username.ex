defmodule Username do
  # https://exercism.org/tracks/elixir/exercises/german-sysadmin/

  @doc """
  Sanitize existing usernames by removing everything but lowercase letters
  It will Allow underscores and substitute German characters
  """
  @spec sanitize(username :: charlist()) :: charlist()
  def sanitize(''), do: ''

  def sanitize([first_char | other_chars]) do
    sanitized =
      case first_char do
        # Substitute German Character
        # ä becomes ae
        # ö becomes oe
        # ü becomes ue
        # ß becomes ss
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        # Only lowercase characters
        # pattern matching, char = first_char
        char when char >= ?a and char <= ?z -> [char]
        # Allow underscores
        ?_ -> '_'
        _ -> ''
      end

    sanitized ++ sanitize(other_chars)
  end
end
