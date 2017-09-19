require ExMtgDownloader.Structures.Card

defmodule ExMtgDownloader.MagicSpoiler.Cards do

  def info(card_url) do
    get_html_card(card_url)
      |> parse_card(card_url)
  end

  def get_html_card(card_url) do
    case HTTPoison.get(card_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("erro ao fazer downlaod", reason)
        ""
    end
  end

  def parse_card(source_card, url) do
    name = Floki.find(source_card, "h1.card-title")
      |> Floki.text
    image = Floki.find(source_card, ".scard img")
      |> Floki.attribute("src")
      |> List.first
    attributes = Floki.find(source_card, "ul li.card-type")
    type = attributes
      |> Enum.at(1)
      |> Floki.text
      |> String.replace("Type: ", "")

    rarity = attributes
      |> Enum.at(2)
      |> Floki.text
      |> String.replace("Rarity: ", "")

    {:ok, %ExMtgDownloader.Structures.Card{name: name,
        image: image, url: url, type: type, rarity: rarity}}
  end

end
