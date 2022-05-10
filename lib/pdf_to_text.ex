defmodule PdfToText do
  @moduledoc """
  Extracts text from PDFs.

  This module is a GenServer, that must be started before the fun starts:

      {:ok, content} = File.read("test/test_files/minimal.pdf")
      {:ok, pid } = PdfToText.start_link([])
      PdfToText.from_content(pid, content)
  """

  use GenServer

  alias PdfToText.Native

  ## Client API

  @doc """
  Starts the pdf parser GenServer.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Extracts text from the given PDF content.
  """
  def from_content(server, bytes) do
    GenServer.call(server, {:from_content, bytes})
  end

  @doc """
  Extracts text from the a PDf file with the given path.
  """
  def from_path(server, path) do
    GenServer.call(server, {:from_path, path})
  end

  ## Server API

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:from_content, bytes}, from, state) do
    native_from_content(from, bytes)
    {:noreply, state}
  end

  @impl true
  def handle_call({:from_path, path}, from, state) do
    native_from_path(from, path)
    {:noreply, state}
  end

  @impl true
  def handle_info({:receive_pdf_text, from, result}, state) do
    GenServer.reply(from, result)
    {:noreply, state}
  end

  defp native_from_content(from, content),
    do: Native.from_content(self(), :receive_pdf_text, from, content)

  defp native_from_path(from, path), do: Native.from_path(self(), :receive_pdf_text, from, path)
end
