defmodule Rfc1123DateTime.MixProject do
  use Mix.Project

  def project do
    [
      app: :rfc1123_datetime,
      version: "0.1.2",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      package: package()
    ]
  end

  def package do
    [
      description: "RFC 1123 date time parser",
      licenses: ["Apache-2.0"],
      links: %{
        "github" => "https://github.com/dkuku/rfc1123_datetime"
      }
    ]
  end

  def application do
    [
      extra_applications: []
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:nimble_parsec, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases() do
    [
      publish: [
        "format",
        "cmd rm -f lib/rfc1123_datetime_parsec.ex",
        "nimble_parsec.compile lib/rfc1123_datetime_parsec.ex.exs",
        "compile",
        "cmd mix docs",
        "cmd mix hex.publish"
      ]
    ]
  end
end
