defmodule ZohoTest do
  use ExUnit.Case, async: false

  test "URLs" do
    assert Zoho.Accounts.endpoint == "/Accounts/getRecords?authtoken=testkey&scope=crmapi"
    assert Zoho.Accounts.postendpoint == "/Accounts/insertRecords?authtoken=testkey&scope=crmapi&xmlData="

    assert Zoho.Contacts.endpoint == "/Contacts/getRecords?authtoken=testkey&scope=crmapi"
    assert Zoho.Contacts.postendpoint == "/Contacts/insertRecords?authtoken=testkey&scope=crmapi&xmlData="

    assert Zoho.Deals.endpoint == "/SalesOrders/getRecords?authtoken=testkey&scope=crmapi"
    assert Zoho.Deals.postendpoint == "/SalesOrders/insertRecords?authtoken=testkey&scope=crmapi&xmlData="

    assert Zoho.Leads.endpoint == "/Leads/getRecords?authtoken=testkey&scope=crmapi"
    assert Zoho.Leads.postendpoint == "/Leads/insertRecords?authtoken=testkey&scope=crmapi&xmlData="    
  end

  test "Process Url" do
    assert Zoho.process_url("/x") == "https://test.domain/crm/private/json/x"
  end

  test "can dynamically change domain via Application config" do
    Application.put_env(:zoho, :domain, "abc.def")
    assert Zoho.process_url("/x") == "https://abc.def/crm/private/json/x"

    Application.put_env(:zoho, :domain, "test.domain")
    assert Zoho.process_url("/x") == "https://test.domain/crm/private/json/x"
  end

  test "can dynamically change auth key" do
    Application.put_env(:zoho, :auth_key, "supersecret")
    assert Zoho.Accounts.endpoint == "/Accounts/getRecords?authtoken=supersecret&scope=crmapi"

    Application.put_env(:zoho, :auth_key, "testkey")
    assert Zoho.Accounts.endpoint == "/Accounts/getRecords?authtoken=testkey&scope=crmapi"
  end
end
