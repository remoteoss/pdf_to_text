defmodule PdfToText do
  @moduledoc """
  `PdfToText` gives you the text content of a PDF.

  If you have the PDF file content at hand, use `from_content/1`,
  if you have a file, use `from_path/1`.
  """

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  use RustlerPrecompiled,
    otp_app: :pdf_to_text,
    crate: "pdf_to_text",
    base_url: "#{github_url}/releases/download/v#{version}",
    version: version,
    force_build: System.get_env("PDF_TO_TEXT_BUILD") in ["1", "true"]

  # When your NIF is loaded, it will override these functions.
  @doc """
  Extracts text from the pdf file content given
  """
  @spec from_content(String.t()) :: String.t()
  def from_content(_pdf_content), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Extracts text from the pdf file given by its path.
  """
  @spec from_path(String.t()) :: String.t()
  def from_path(_pdf_path), do: :erlang.nif_error(:nif_not_loaded)
end
