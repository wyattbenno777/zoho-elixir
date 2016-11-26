defmodule Zoho.Account do
  @moduledoc """
  The Struct and type definition for a Zoho Accounts
  """

  @type t :: %Zoho.Account{
                      response: %{}
  }

  defstruct           response: %{}

end
