defmodule PdfToText.MixProject do
  use Mix.Project

  def project do
    [
      app: :pdf_to_text,
      version: "0.0.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),

      # Docs
      name: "PdfToText",
      source_url: "https://github.com/remoteoss/pdf_to_text",
      docs: [
        main: "PdfToText",
        extras: ["README.md"]
      ]
    ]
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w[
        lib
        native/pdf_to_text/src
        native/pdf_to_text/Cargo.*
        native/pdf_to_text/README.md
        native/pdf_to_text/.cargo
        checksum-Elixir.PdfToText.exs
        .formatter.exs
        mix.exs
        README.md
        LICENSE.md
        ],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/remoteoss/pdf_to_text",
        "Docs" => "https://hexdocs.pm/pdf_to_text"
      },
      source_url: "https://github.com/remoteoss/pdf_to_text"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.3"},
      {:rustler, ">= 0.0.0", optional: true},
      {:ex_doc, "~> 0.28", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
