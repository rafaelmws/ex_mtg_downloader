defmodule ExMtgDownloader.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      ExMtgDownloader.FiveColors.Repo,
      # Starts a worker by calling: ExMtgDownloader.Worker.start_link(arg)
      # {ExMtgDownloader.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExMtgDownloader.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
