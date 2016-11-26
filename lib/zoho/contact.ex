defmodule Zoho.Contact do
  @moduledoc """
  The Struct and type definition for a Zoho Contacts
  """

  @type t :: %Zoho.Contact{
                      response: %{}
  }

  defstruct           response: %{}

end
