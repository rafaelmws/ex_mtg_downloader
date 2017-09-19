defmodule ExMtgDownloader.MagicSpoiler.CardTest do

  use ExUnit.Case

  @card "http://www.magicspoiler.com/mtg-spoiler/adanto-vanguard/"

  setup_all do
    {:ok, card} = ExMtgDownloader.MagicSpoiler.Cards.info(@card)
    {:ok, card: card}
  end

  # :name, :url, :image, :text, :cost, :type, :flavor

  test "name is correct", %{card: card} do
    assert card.name == "Adanto Vanguard"
  end

  test "image is correct", %{card: card} do
    assert card.image == "http://www.magicspoiler.com/wp-content/uploads/2017/09/Adanto-Vanguard-Ixalan-Spoiler.png"
  end

  test "url is correct", %{card: card}  do
    assert card.url == @card
  end

  test "type is correct", %{card: card} do
    assert card.type == "Creature  - Soldier, Vampire"
  end

  test "rarity is correct", %{card: card} do
    assert card.rarity == "Uncommon"
  end

end
