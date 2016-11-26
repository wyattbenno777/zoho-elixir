defmodule Zoho.Mixfile do
  use Mix.Project

  def project do
    [
      app: :zoho,
      version: "0.0.1",
      source_url: "https://github.com/wyattbenno777/zoho-elixir",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.2.2"},
      {:httpotion, "~> 0.2.0"},
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
