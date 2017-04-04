defmodule Zoho do
  use HTTPotion.Base

  @spec process_url(String.t) :: String.t
  def process_url(path) do
    "https://#{domain()}/crm/private/json" <> path
  end


  defp auth_key do
    Application.get_env(:zoho, :auth_key)
  end

  defp domain do
    Application.get_env(:zoho, :domain) || "crm.zoho.com"
  end
end
