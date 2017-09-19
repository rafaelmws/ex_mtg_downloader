defmodule ExMtgDownloader.Structures.Card do
  @enforce_keys [:name, :url, :image]
  defstruct [:name, :url, :image, :text, :cost, :type, :flavor, :rarity]
end
