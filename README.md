# PdfToText

Extracts text from a PDF file. Still just an experiment - but might be open
sourced if we actually end up using it 🎉

## Installation

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
