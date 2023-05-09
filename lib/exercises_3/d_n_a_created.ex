defmodule DNACreated do
  # https://exercism.org/tracks/elixir/exercises/dna-encoding

  # DNA Exercise that i done
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

  def encode(dna), do: do_encode_each(dna, <<>>)

  defp do_encode_each([], nucleotide), do: <<nucleotide::bitstring>>

  defp do_encode_each([head | tail], nucleotide) do
    first_nucleotide = <<encode_nucleotide(head)::4>>

    nucleotides = <<nucleotide::bitstring, first_nucleotide::bitstring>>
    do_encode_each(tail, nucleotides)
  end

  def decode(dna), do: do_decode_each(dna, '') |> reverse()

  defp do_decode_each(<<>>, nucleotide), do: nucleotide

  defp do_decode_each(<<head::4, rest::bitstring>>, nucleotide) do
    first_nucleotide = decode_nucleotide(head)

    do_decode_each(rest, [first_nucleotide | nucleotide])
  end

  defp reverse(charlist), do: do_reverse(charlist, [])

  defp do_reverse([], reversed_charlist), do: reversed_charlist

  defp do_reverse([head | tail], charlist) do
    do_reverse(tail, [head | charlist])
  end
end
