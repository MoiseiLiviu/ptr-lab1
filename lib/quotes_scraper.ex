defmodule ScrapeQuotes do
  use HTTPoison.Base

  @url "https://quotes.toscrape.com/"

  def start do
    response = get(@url) |> elem(1)
    IO.puts "RESPONSE BODY : #{response.body}"
    quotes = extract_quotes(response.body)
    write_quotes_to_file(quotes)
    IO.puts "Extracted #{length(quotes)} quotes and saved them to quotes.json."
  end

  defp extract_quotes(body) do
    {:ok, doc} = Floki.parse_document(body)
    quotes = Floki.find(doc, ".quote")
    Enum.map(quotes, fn quote ->
      author = Floki.find(quote, ".author") |> hd() |> Floki.text()
      text = Floki.find(quote, ".text") |> hd() |> Floki.text()
      tags = Floki.find(quote, ".tag") |> Enum.map(&Floki.text/1)
      %{author: author, text: text, tags: tags}
    end)
  end

  defp write_quotes_to_file(quotes) do
    File.write("quotes.json", Poison.encode!(quotes))
  end
end