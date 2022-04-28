defmodule PdfToText do
  @moduledoc """
  Documentation for `PdfToText`.
  """

  use Rustler, otp_app: :pdf_to_text, crate: "pdf_to_text"

  # When your NIF is loaded, it will override these functions.
  def from_content(_pdf_content), do: :erlang.nif_error(:nif_not_loaded)
  def from_path(_pdf_path), do: :erlang.nif_error(:nif_not_loaded)
end
