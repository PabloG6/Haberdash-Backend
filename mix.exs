defmodule Haberdash.MixProject do
  use Mix.Project

  def project do
    [
      app: :haberdash,
      version: "0.1.0",
      elixir: "~> 1.10.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Haberdash.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support"]

  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.1"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_live_view, "~> 0.14.6"},
      {:stripity_stripe, "~> 2.9.0"},
      {:phoenix_live_dashboard, "~> 0.2.0"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:poison, "~> 4.0.1"},
      {:nebulex, "~> 2.0.0-rc"},
      {:decorator, "~> 1.3"},
      {:ecto_enum, "~> 1.4.0"},
      {:google_maps, "~> 0.11"},
      {:bcrypt_elixir, "~> 2.2.0"},
      {:gproc, "~> 0.8.0"},
      {:guardian, "~> 2.0"},
      {:plug_cowboy, "~> 2.0"},
      {:ex_machina, "~> 2.4"},
      {:faker, "~> 0.14.0"},
      {:uuid, "~> 1.1.8"},
      {:exconstructor, "~> 1.1.0"},
      {:maptu, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
