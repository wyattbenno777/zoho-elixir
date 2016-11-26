defmodule Zoho.Contacts do
  auth_key =  System.get_env("ZOHO_AUTH_KEY") || Application.get_env(:zoho, :auth_key)
  @endpoint "/Contacts/getRecords?authtoken=#{auth_key}&scope=crmapi"
  @resource Zoho.Contact
  use Zoho.Resource

  #clean up strange data format
  def get_clean do
     data = Zoho.Contacts.get

     top = data.response["result"]["Contacts"]["row"]
     if is_list top do
       data2 = top
       data3 = Enum.map(data2, fn(y) -> Enum.map(y["FL"], fn(x) -> %{x["val"] => x["content"]} end) end)
       Enum.map(data3, fn(y) -> Enum.reduce(y, %{}, fn (map, acc) -> Map.merge(acc, map) end) end)
     else
       data2 = top["FL"]
       Enum.map(data2, fn(x) -> %{x["val"] => x["content"]} end)
     end
  end

end
