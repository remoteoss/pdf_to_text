defmodule Benchmark do
  @pdf_content File.read("test/test_files/minimal.pdf")

  def parallel(num) do
    caller = self()

    @pdf_content
    |> List.duplicate(num)
    |> Enum.map(fn {:ok, content} ->
      spawn(fn -> PdfToText.Native.from_content(caller, :received_pdf_text, self(), content) end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {:received_pdf_text, ^pid, {:ok, pdf_text}} -> pdf_text
      end
    end)
  end

  def sequential(num) do
    {:ok, server} = PdfToText.start_link([])

    @pdf_content
    |> List.duplicate(num)
    |> Enum.map(fn {:ok, content} ->
      {:ok, pdf_text} = PdfToText.from_content(server, content)
      pdf_text
    end)
  end
end

Benchee.run(
  %{
    "parallel" => fn i -> Benchmark.parallel(i) end,
    "sequential" => fn i -> Benchmark.sequential(i) end
  },
  time: 10,
  inputs: [
    {"1", 1},
    {"100", 100},
    {"10_000", 10_000}
  ]
)
