require ExMtgDownloader.Structures.Card

defmodule ExMtgDownloader.MagicSpoiler.Cards do

  def info(card_url) do
    get_html_card(card_url)
      |> parse_card(card_url)
  end

  defp get_file_name(card_url) do
    card = card_url
      |> String.split("/")
      |> Enum.at(4)

    "/tmp/mtg/html/#{card}.html"
  end

  defp downlaod_html(card_url, file_name) do
    IO.puts("[MagicSpoiler.Cards] get info: #{card_url}")
    case HTTPoison.get(card_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        File.write!(file_name, body)
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("erro ao fazer downlaod", reason)
        ""
    end
  end

  def get_html_card(card_url) do
    file_name = get_file_name(card_url)
    if File.exists?(file_name) do
      File.read!(file_name)
    else
      downlaod_html(card_url, file_name)
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

    %ExMtgDownloader.FiveColors.Card{name: name, label: name, artist: "ixalan",
        multiverseid: "ixalan", rate: 0, rate_votes: 0, multiverse_number: "ixalan",
        image: image, url: url, type_label: type, rarity: rarity}
  end

end
