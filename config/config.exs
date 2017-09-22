# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.

use Mix.Config
  config :ex_mtg_downloader, ExMtgDownloader.FiveColors.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true


# You can configure your application as:
#
#     config :ex_mtg_downloader, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:ex_mtg_downloader, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
    # import_config "#{Mix.env}.exs"
