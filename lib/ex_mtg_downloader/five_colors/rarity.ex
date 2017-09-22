defmodule ExMtgDownloader.FiveColors.Rarity do
  use Ecto.Schema

  @primary_key {:id, :decimal, autogenerate: false}
  schema "rarity" do
    field :name
    field :alias
  end

  @fields ~w(name alias)

end
