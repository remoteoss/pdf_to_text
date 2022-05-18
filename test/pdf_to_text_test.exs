defmodule PdfToTextTest do
  use ExUnit.Case
  @test_file_path "./test/test_files/minimal.pdf"
  describe "from_path/1" do
    test "when file is available, parses content correctly" do
      assert {:ok, content} = PdfToText.from_path(@test_file_path)
      assert content =~ "Hello World"
    end

    test "when file isn't available, return error" do
      assert {:error, _} = PdfToText.from_path("not here")
    end
  end

  describe "from_content" do
    test "parses content correctly" do
      content = File.read!(@test_file_path)
      assert {:ok, content} = PdfToText.from_content(content)
      assert content =~ "Hello World"
    end
  end

  test "works with multiple alphabets" do
    assert {:ok, content} = PdfToText.from_path(@test_file_path)

    # Remove direccional unicode and remove breakline
    content =
      content
      |> String.replace("\u202B", "")
      |> String.replace("\u202C", "")
      |> String.replace("\n", " ")

    "HWêëሰልاԲПветবдйтó界ěâაΓεםनयाóỤこӘសួлກдഡ്ကरمśਆиඩ්äกớאM"
    |> String.split("")
    |> Enum.each(&assert content =~ &1)
  end
end
