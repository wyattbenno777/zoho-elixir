defmodule Zoho.Accounts do
  
  @loc "Accounts"
  @resource Zoho.Account

  use Zoho.Resource


  #get example map for Accounts post
  def get_example do

    example = %{"Account Name": "Zillum",
     "Website": "www.zillum.com",
     "Employees": "200",
     "Ownership": "Private",
     "Industry": "testing@testing.com",
     "Fax": "99999",
     "Annual Revenue": "2000000"}

    example
  end

  #clean up strange data format
  def get_clean do
     data = Zoho.Accounts.get

     top = data.response["result"]["Accounts"]["row"]
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
