defmodule Zoho do
  use HTTPotion.Base

  @spec process_url(String.t) :: String.t
  def process_url(path) do
    "https://crm.zoho.com/crm/private/json" <> path
  end

  @spec process_request_headers(map) :: map
  def process_request_headers(headers) do
    Dict.put headers, :Authorization, "Bearer #{auth_key}"
  end

  defp auth_key do
    System.get_env("ZOHO_AUTH_KEY") || Application.get_env(:zoho, :auth_key)
  end
end
