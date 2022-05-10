defmodule PdfToText.NativeTest do
  use ExUnit.Case

  test "read PDFs in parallel" do
    caller = self()

    ["test", "test_files", "minimal.pdf"]
    |> Path.join()
    |> File.read()
    |> List.duplicate(42)
    |> Enum.map(fn {:ok, content} ->
      spawn(fn -> PdfToText.Native.from_content(caller, :received_pdf_text, self(), content) end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {:received_pdf_text, ^pid, response} -> response
      end
    end)
    |> Enum.each(fn result ->
      assert {:ok, "Hello World\n\n;"} = result
    end)
  end
end
