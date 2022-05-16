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

    assert content ==
             "Hello Wêreld Përshendetje Botë ሰላም ልዑል بالعالم مرحبا Բարեւ աշխարհ Kaixo Mundua Прывітанне Сусвет ওহে বিশ্ব Здравей свят Hola món Moni Dziko Lapansi 你好世界！ Pozdrav svijete Ahoj světe Hej Verden Hallo Wereld Hello World Tere maailm Hei maailma Bonjour monde Hallo wrâld გამარჯობა მსოფლიო Hallo Welt Γειά σου Κόσμε Sannu Duniya עולם שלום नमस्ते दनि या Helló Világ Halló heimur Ndewo Ụwa Halo Dunia Ciao mondo こんにちは世界 Сәлем Әлем សួស​ព ិភពលោក Салам дүйнө ສະ​ບາຍ​ດີ​ຊາວ​ໂລກ Sveika pasaule Labas pasauli Moien Welt Здраво свету Hai dunia ഹലോ വേൾഡ് Сайн уу дэлхий မင်္ဂလာပါကမ္ဘာလောက नमस्कार संसार Hei Verden نړی سالم دنیا سالم Witaj świecie Olá Mundo ਸਤਿ ਸ੍ਰੀ ਅਕਾਲ ਦੁਨਿਆ Salut Lume Привет мир Hàlo a Shaoghail Здраво Свете  ;Lefatše Lumela හෙලෝ වර්ල්ඩ් Pozdravljen svet Hola Mundo Halo Dunya Salamu Dunia Hej världen Салом Ҷаҳон สวัสดีชาวโลก Selam Dünya Привіт Світ Salom Dunyo Chào thế giới Helo Byd Molo Lizwe וועלט העלא Mo ki O Ile Aiye Sawubona Mhlaba  ;"
  end
end
