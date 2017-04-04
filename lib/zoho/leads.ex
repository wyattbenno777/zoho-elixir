defmodule Zoho.Leads do

  @loc "Leads"
  @resource Zoho.Lead
  use Zoho.Resource

  defp auth_key do
    Application.get_env(:zoho, :auth_key)
  end

  def endpoint do
    "/Leads/getRecords?authtoken=#{auth_key()}&scope=crmapi"
  end

  def postendpoint do
    "/Leads/insertRecords?authtoken=#{auth_key()}&scope=crmapi&xmlData="
  end

  #get example map for Leads post
  def get_example do

    example = %{"Lead Source": "Web Download",
     "Company": "Your Company",
     "First Name": "Hannah",
     "Last Name": "smith",
     "Email": "testing@testing.com",
     "Title": "Manager",
     "Phone": "1234567890",
     "Home Phone": "0987654321",
     "Other Phone": "111",
     "Fax": "222",
     "Mobile": "123"}

    example
  end

  #clean up strange data format
  def get_clean do
     data = Zoho.Leads.get

     top = data.response["result"]["Leads"]["row"]
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
