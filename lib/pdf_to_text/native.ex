defmodule PdfToText.Native do
  use Rustler, otp_app: :pdf_to_text, crate: "pdf_to_text"

  defp err, do: :erlang.nif_error(:nif_not_loaded)

  # When your NIF is loaded, it will override these functions.
  def from_content(_identifier, _from, _pdf_content), do: err()
  def from_path(_identifier, _from, _pdf_path), do: err()
end
