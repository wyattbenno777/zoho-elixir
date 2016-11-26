# Zoho

Zoho API client for Elixir

** Part time learning Elixir & utility project **

## Scope

Make basic Elixir Zoho CRM API Connection

### SUPPORTS

- [ ] Accounts (get, get_clean)
- [ ] Contacts (get, get_clean)
- [ ] Deals (get, get_clean)
- [ ] Leads (get, get_clean)

## Usage

Auth is done from either the enviromental variable ZOHO_AUTH_KEY or auth_key
in the config file.

Generate your auth token via get request:
https://accounts.zoho.com/apiauthtoken/nb/create?SCOPE=ZohoCRM/crmapi&EMAIL_ID=[Username/EmailID]&PASSWORD=[Password]&DISPLAY_NAME=[ApplicationName]

Get dependencies:
mix deps.get

Run tests:
mix test

Try it from iex:
iex -S mix

```Elixir
Zoho.start

leads = Zoho.Leads.get

List.first (leads.response["result"]["Leads"]["row"])
  #  %{"FL" => [%{"content" => "2223345000000110264", "val" => "LEADID"},
  #   %{"content" => "2223345000000109005", "val" => "SMOWNERID"},
  #   %{"content" => "Wyatt Benno", "val" => "Lead Owner"},
  #   %{"content" => "fafaf", "val" => "Company"},
  #   %{"content" => "fafa", "val" => "First Name"},
  #   %{"content" => "fafaf", "val" => "Last Name"},
  #   %{"content" => "fafa", "val" => "Designation"},
  #   %{"content" => "fa@ca.com", "val" => "Email"},
  #   %{"content" => "123", "val" => "Phone"},
  #   %{"content" => "fafa", "val" => "Fax"},
  #   %{"content" => "123", "val" => "Mobile"},
  #   %{"content" => "afaf.com", "val" => "Website"},
  #   %{"content" => "社員からの紹介", "val" => "Lead Source"},
  #   %{"content" => "ERP関連企業", "val" => "Industry"},
  #   %{"content" => "1313131313", "val" => "Annual Revenue"},
  #   %{"content" => "2223345000000109005", "val" => "SMCREATORID"},
  #   %{"content" => "Wyatt Benno", "val" => "Created By"},
  #   %{"content" => "2223345000000109005", "val" => "MODIFIEDBY"},
  #   %{"content" => "Wyatt Benno", "val" => "Modified By"},
  #   %{"content" => "2016-11-26 10:32:15", "val" => "Created Time"},
  #   %{"content" => "2016-11-26 10:32:15", "val" => "Modified Time"},
  #   %{"content" => "false", "val" => "Email Opt Out"},
  #   %{"content" => "2016-11-26 10:32:15", "val" => "Last Activity Time"}],
  #  "no" => "1"}

leads = Zoho.Leads.get_clean

  #[%{"Annual Revenue" => "1313131313", "Company" => "fafaf",
  #   "Created By" => "Wyatt Benno", "Created Time" => "2016-11-26 10:32:15",
  #   "Designation" => "fafa", "Email" => "fa@ca.com", "Email Opt Out" => "false",
  #   "Fax" => "fafa", "First Name" => "fafa", "Industry" => "ERP関連企業",
  #   "LEADID" => "2223345000000110264",
  #   "Last Activity Time" => "2016-11-26 10:32:15", "Last Name" => "fafaf",
  #   "Lead Owner" => "Wyatt Benno", "Lead Source" => "社員からの紹介",
  #   "MODIFIEDBY" => "2223345000000109005", "Mobile" => "123",
  #   "Modified By" => "Wyatt Benno", "Modified Time" => "2016-11-26 10:32:15",
  #   "No of Employees" => "0", "Phone" => "123",
  #   "SMCREATORID" => "2223345000000109005", "SMOWNERID" => "2223345000000109005",
  #   "Website" => "afaf.com"},
  # %{"Annual Revenue" => "11111111", "City" => "shibuya", "Company" => "test",
  #   "Country" => "japan", "Created By" => "Wyatt Benno",
  #   "Created Time" => "2016-11-26 09:02:53", "Designation" => "test",
  #   "Email" => "test@test.com", "Email Opt Out" => "false",
  #   "First Name" => "test", "Industry" => "データ/通信OEM",
  #   "LEADID" => "2223345000000110182",
  #   "Last Activity Time" => "2016-11-26 09:02:53", "Last Name" => "test",
  #   "Lead Owner" => "Wyatt Benno", "Lead Source" => "広告",
  #   "MODIFIEDBY" => "2223345000000109005", "Mobile" => "111-0000-1234",
  #   "Modified By" => "Wyatt Benno", "Modified Time" => "2016-11-26 09:02:53",
  #   "No of Employees" => "0", "Phone" => "111-0000-1234",
  #   "SMCREATORID" => "2223345000000109005", "SMOWNERID" => "2223345000000109005",
  #   "State" => "tokyo", "Street" => "test address"}]

```
