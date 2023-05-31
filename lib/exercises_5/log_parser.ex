defmodule LogParser do
  def valid_line?(line) do
    line |> String.match?(~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\]/)
  end

  def split_line(line) do
    line |> String.split(~r/[<][*,~,*,=,-]{1,4}[>]/)
  end

  def remove_artifacts(line) do
    line |> String.replace(~r/end-of-line[0-9]{0,9}\d/i, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User[ |\n|\t]{0,9}([^\s]+)/, line) do
      [_, capture] -> "[USER] #{capture} #{line}"
      nil -> line
    end
  end
end
