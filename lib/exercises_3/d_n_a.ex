defmodule DNA do
  # https://exercism.org/tracks/elixir/exercises/dna-encoding

  def encode_nucleotide(code_point) do
    case code_point do
      32 -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(binary) do
    case binary do
      0b0000 -> 32
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], acc), do: acc

  defp do_encode([n | rest], acc) do
    do_encode(rest, <<acc::bitstring, encode_nucleotide(n)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, acc), do: acc |> reverse()

  defp do_decode(<<n::4, rest::bitstring>>, acc) do
    do_decode(rest, [decode_nucleotide(n) | acc])
  end

  defp reverse(l), do: do_reverse(l, [])

  defp do_reverse([], acc), do: acc

  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
end
