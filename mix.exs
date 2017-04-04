defmodule Zoho.Mixfile do
  use Mix.Project

  def project do
    [
      app: :zoho,
      version: "0.0.3",
      source_url: "https://github.com/wyattbenno777/zoho-elixir",
      elixir: "~> 1.4",
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  def application do
    [applications: [:logger, :ibrowse, :httpotion]]
  end

  defp deps do
    [
      {:ibrowse, "~> 4.2"},
      {:httpotion, "~> 3.0.2"},
      {:jazz, "~> 0.2"}
    ]
  end

  defp description do
    """
    Elixir wrapper for Zoho CRM API.
    Full documentation can be found at https://www.zoho.com/crm/help/api/
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{github: "https://github.com/wyattbenno777/zoho-elixir"},
      contributors: ["Wyatt Benno"]
    ]
  end
end
