defmodule Zoho.Deals do
  
  @loc "SalesOrders"
  @resource Zoho.Deal
  use Zoho.Resource


  defp auth_key do
    Application.get_env(:zoho, :auth_key)
  end
  
  def endpoint do
    "/Deals/getRecords?authtoken=#{auth_key()}&scope=crmapi"
  end

  def postendpoint do
    "/Deals/SalesOrders?authtoken=#{auth_key()}&scope=crmapi&xmlData="
  end

  #clean up strange data format
  def get_clean do
     data = Zoho.Deals.get

     top = data.response["result"]["Deals"]["row"]
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
