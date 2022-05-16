defmodule PdfToText do
  @moduledoc """
  Documentation for `PdfToText`.
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
  def from_content(_pdf_content), do: :erlang.nif_error(:nif_not_loaded)
  def from_path(_pdf_path), do: :erlang.nif_error(:nif_not_loaded)
end
