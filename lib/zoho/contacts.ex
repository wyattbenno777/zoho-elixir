defmodule Zoho.Contacts do
  
  @loc "Contacts"
  @resource Zoho.Contact

  use Zoho.Resource

  #get example map for Contacts post
  def get_example do

    example = %{"First Name": "Scott",
     "Last Name": "James",
     "Email": "test@test.com",
     "Department": "CG",
     "Phone": "999999999",
     "Fax": "999999999",
     "Mobile": "999999999",
     "Assistant": "John"}

    example
  end

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
