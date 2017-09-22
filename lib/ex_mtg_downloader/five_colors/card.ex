defmodule ExMtgDownloader.FiveColors.Card do
  use Ecto.Schema
  alias ExMtgDownloader.FiveColors

  @primary_key {:id, :decimal, autogenerate: false}
  schema "card" do
    field :name
    field :label
    field :text
    field :multiverseid
    field :rate, :integer
    field :rate_votes, :integer
    field :manacost_label
    field :combatpower_label
    field :colorindicator
    field :type_label
    field :id_asset, :integer
    field :multiverse_number
    field :artist

    field :image, :string, virtual: true
    field :url, :string, virtual: true
    field :rarity, :string, virtual: true

    field :id_expansion, :integer
    field :id_rarity, :integer

  end

  @fields ~w(name label expansion image)

end
