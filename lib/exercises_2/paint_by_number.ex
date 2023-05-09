defmodule PaintByNumber do
  # https://exercism.org/tracks/elixir/exercises/paint-by-number/edit

  def palette_bit_size(color_count) do
    count_bits(color_count, 1)
  end

  defp count_bits(color_count, bit_size) do
    cond do
      Integer.pow(2, bit_size) >= color_count -> bit_size
      true -> count_bits(color_count, bit_size + 1)
    end
  end

  def empty_picture, do: <<>>

  def test_picture, do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)

    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)

    cond do
      picture == empty_picture() ->
        nil

      true ->
        <<value::size(bit_size), _::bitstring>> = picture
        value
    end
  end

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)

    cond do
      picture == empty_picture() ->
        empty_picture()

      true ->
        <<_::size(bit_size), rest::bitstring>> = picture
        rest
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
