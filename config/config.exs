# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :zoho,
  auth_key: "",
  domain: ""

import_config "#{Mix.env}.exs"
