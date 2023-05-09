defmodule FileSniffer do
  def type_from_extension("exe"), do: "application/octet-stream"
  def type_from_extension("bmp"), do: "image/bmp"
  def type_from_extension("png"), do: "image/png"
  def type_from_extension("jpg"), do: "image/jpg"
  def type_from_extension("gif"), do: "image/gif"
  def type_from_extension(_), do: nil

  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7F, 0x45, 0x4C, 0x46, _::binary>> -> "exe"
      <<0x42, 0x4D, _::binary>> -> "bmp"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>> -> "png"
      <<0xFF, 0xD8, 0xFF, _::binary>> -> "jpg"
      <<0x47, 0x49, 0x46, _::binary>> -> "gif"
      _ -> ""
    end
    |> type_from_extension
  end

  def verify(file_binary, extension) do
    extension_type = type_from_binary(file_binary)
    file_type = type_from_extension(extension)

    if extension_type == file_type do
      {:ok, extension_type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
