# PdfToText

Extracts text from a PDF file. Still just an experiment 🎉

## License

Using GPLv2 due to the usage of said license on Poppler.

## Installation

## Install Rust

Use Rustup to install Rust:
`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

### Install Poppler

- For OSX: `brew install poppler`
- For Debian: `apt-get install libpoppler-glib-dev`

### Add dependency to Elixir project

```elixir
def deps do
  [
    {:pdf_to_text, git: "https://github.com/remoteoss/pdf_to_text.git"}
  ]
end
```
