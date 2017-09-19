defmodule ExMtgDownloader.MagicSpoiler.IndexTest do
  use ExUnit.Case

  @edition "ixalan-card-list"

  test "get all cards" do
    cards = ExMtgDownloader.MagicSpoiler.Index.all_cards(@edition)
    assert Enum.count(cards) == 288
  end

end
