defmodule Zoho.Leads do
  auth_key =  System.get_env("ZOHO_AUTH_KEY") || Application.get_env(:zoho, :auth_key)
  @endpoint "/Leads/getMyRecords?authtoken=#{auth_key}&scope=crmapi"
  @resource Zoho.Lead
  use Zoho.Resource
end
