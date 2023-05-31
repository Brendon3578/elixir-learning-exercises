defmodule TopSecretOld do
  def to_ast(string), do: string |> Code.string_to_quoted!()

  def decode_secret_message_part({operation, _, arguments} = ast, acc) do
    case operation do
      x when x in [:def, :defp] ->
        {second_operation, _, second_arguments} = hd(arguments)

        sliced_function_name =
          case second_operation do
            x when x in [:when] -> hd(second_arguments) |> extract_ast_function()
            _ -> hd(arguments) |> extract_ast_function()
          end

        {ast, [sliced_function_name | acc]}

      _ ->
        {ast, acc}
    end
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp extract_ast_function({function_name, _, function_args}) do
    arity = if function_args != nil, do: length(function_args), else: 0

    if arity > 0, do: function_name |> to_string |> String.slice(0..(arity - 1)), else: ""
  end

  def decode_secret_message(string) do
    {_, acc} =
      string
      |> to_ast()
      |> Macro.prewalk([], fn
        {:def, meta, children}, acc -> decode_secret_message_part({:def, meta, children}, acc)
        {:defp, meta, children}, acc -> decode_secret_message_part({:defp, meta, children}, acc)
        other, acc -> {other, acc}
      end)

    Enum.reverse(acc) |> to_string()
  end
end
