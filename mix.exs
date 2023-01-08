defmodule CNPJ.MixProject do
  use Mix.Project

  def project do
    [
      app: :cnpj,
      version: "0.2.0",
      elixir: "~> 1.6",
      package: package(),
      description: description(),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_file: {:no_warn, "plts/dialyzer.plt"},
        plt_add_apps: [:mix, :ex_unit, :ecto, :ecto_sql]
      ],
      deps: deps()
    ]
  end

  def description do
    "A Brazilian CNPJ validation written in Elixir."
  end

  def package do
    [
      name: "cnpj",
      maintainers: ["Ulisses Almeida"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ulissesalmeida/cnpj"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, only: :dev, runtime: false},
      {:credo, "~> 1.3", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:benchee, "~> 1.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ] ++ ecto_deps()
  end

  defp ecto_deps do
    [
      {:ecto, "~> 3.2", optional: true},
      {:ecto_sql, "~> 3.2", only: [:dev, :test], optional: true}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
