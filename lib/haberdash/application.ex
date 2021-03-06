defmodule Haberdash.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    :ets.new(:haberdash_api_key, [:set, :protected, :named_table])

    children = [
      # Start the Ecto repository
      Haberdash.Repo,
      # Start the Telemetry supervisor
      HaberdashWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Haberdash.PubSub},
      # Start the Endpoint (http/https)
      HaberdashWeb.Endpoint,
      {Haberdash.Transactions.OrderSupervisor,
       name: Haberdash.Transactions.OrderSupervisor, strategy: :one_for_one},
      {Haberdash.Listener.Franchise, name: Haberdash.Listener.Franchise},
      Haberdash.Account.Cache,
      Haberdash.Auth.Cache,
      Haberdash.Transactions.PersistOrderState,
      Haberdash.Transactions.PersistCheckoutState,
      # Start a worker by calling: Haberdash.Worker.start_link(arg)
      # {Haberdash.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Haberdash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HaberdashWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
