defmodule PdfToText.MixProject do
  use Mix.Project

  def project do
    [
      app: :pdf_to_text,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
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
