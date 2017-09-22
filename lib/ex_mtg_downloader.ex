alias ExMtgDownloader.MagicSpoiler
alias ExMtgDownloader.FiveColors
alias Ecto.Query

import Ecto.Query, only: [from: 2]

defmodule ExMtgDownloader do

  @id_asset_start 13000

  def sync(edition_name, spoiler_url) do
    rarities = get_all_rarities()
    expansion = get_edition(edition_name)
    cards = MagicSpoiler.Index.all_cards(spoiler_url)
      |> Enum.map(fn card -> MagicSpoiler.Cards.info(card) end)
      |> Enum.filter(fn card -> card.type_label != "Basic Land" end)
      |> Enum.map(fn card -> %FiveColors.Card{card | id_expansion: Decimal.to_integer(expansion.id)} end)
      |> Enum.map(fn card -> update_rarity(card, rarities) end)

    cards
      |> Enum.map(fn card -> downlaod_image(card, cards) end)
      |> Enum.map(fn card -> FiveColors.Repo.insert(card) end)

  end

  defp get_id(card, all_cards) do
    index_card = Enum.find_index(all_cards, fn c -> c.name == card.name end)
    id_asset = index_card + @id_asset_start
    count_by_name = all_cards
      |> Enum.filter(fn c -> c.id == id_asset end)
      |> Enum.count

    if count_by_name == 1 do
      id_asset
    else
      id_asset + Enum.count(all_cards)
    end
  end

  def downlaod_image(card, all_cards) do
    id_asset = get_id(card, all_cards)
    new_card = %FiveColors.Card{card | id_asset: id_asset, id: id_asset}
    file_name = "/tmp/mtg/#{new_card.id_asset}"

    if not File.exists?(file_name) do
      IO.puts("[downlaod_image] Download Image: #{card.image}")
      %HTTPoison.Response{body: body} = HTTPoison.get!(card.image)
      File.write!(file_name, body)
      IO.puts("[downlaod_image] Arquivo escrito: #{file_name}")
    end
    new_card
  end

  def get_edition(edition) do
    FiveColors.Repo.one(from edition in FiveColors.Expansion,
      where: edition.label == ^edition)
  end

  def get_all_rarities do
    FiveColors.Rarity
      |> FiveColors.Repo.all
  end

  def update_rarity(card, all_rarities) do
    rarity = all_rarities
      |> Enum.find(fn r -> r.name == card.rarity end)

    if rarity != nil do
      %FiveColors.Card{card | id_rarity: Decimal.to_integer(rarity.id)}
    else
      %FiveColors.Card{card | id_rarity: 0}
    end

  end

end
