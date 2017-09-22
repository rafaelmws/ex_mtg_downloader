defmodule ExMtgDownloader.FiveColors.Expansion do
  use Ecto.Schema

  @primary_key {:id, :decimal, autogenerate: false}
  schema "expansion" do
    field :name
    field :label
  end

  @fields ~w(name label)

end
