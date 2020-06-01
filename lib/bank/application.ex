defmodule Bank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Supervisor.start_link(children(), opts())
  end

  defp children do
    [
      Bank.Repo,
      BankWeb.Telemetry,
      {Phoenix.PubSub, name: Bank.PubSub},
      BankWeb.Endpoint
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Bank.Supervisor
    ]
  end

  def config_change(changed, _new, removed) do
    BankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
