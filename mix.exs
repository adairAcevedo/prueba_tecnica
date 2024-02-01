defmodule PruebaTecnica.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.9"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.1"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:plug_cowboy, "~> 2.5"},
      {:httpoison, "~> 2.1"},
      {:timex, "~> 3.7"},
      {:cors_plug, "~> 3.0"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      # "ecto.setup": ["ecto.create -r Api.Repo", "ecto.migrate -r Api.Repo"],
      "ecto.setup": ["ecto.create -r Api.Repo", "ecto.migrate -r Api.Repo"],
      # "ecto.seeds": ["ecto.api.seeds"],
      # "ecto.seeds": ["cmd mix run #{Path.join(__DIR__, "apps/api/priv/repo/seeds.exs")}"],
      # "mix run #{Path.join(__DIR__, "priv/foo/bar.exs")}"
      "ecto.reset": ["ecto.drop -r Api.Repo", "ecto.setup -r Api.Repo"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind.install default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      test: ["ecto.create -r Api.Repo --quiet", "ecto.migrate -r Api.Repo --quiet", "test"]
    ]
  end
end
