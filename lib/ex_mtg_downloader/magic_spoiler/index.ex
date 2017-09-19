require HTTPoison
require Floki

defmodule ExMtgDownloader.MagicSpoiler.Index do

  @host "http://www.magicspoiler.com"

  def all_cards(edition) do
    get_page(edition)
      |> parse_cards
  end

  def parse_cards(html) do
    Floki.find(html, ".listcard a")
      |> Floki.attribute("href")
  end

  def get_page(edition) do
    url = "#{@host}/#{edition}/"
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("erro ao fazer downlaod", reason)
        ""
    end
  end

end
