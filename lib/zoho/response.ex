defmodule Zoho.Response do

  @type t :: %Zoho.Response{
    status_code: number,
    data: term,
    raw_response: Zoho.Response.http_potion_response
  }
  @type http_potion_response :: %{
    status_code: number,
    body: String.t,
    headers: list
  }

  defstruct data: nil,
            raw_response: nil,
            status_code: nil

  @spec new(HTTPotion.Response) :: Zoho.Response | {:error, term}
  def new(response) do
    new(response, %{})
  end

  @spec new(HTTPotion.Response, map) :: Zoho.Response | {:error, term}
  def new(response, options) do
    case parse_body(response, options) do
      {:ok, data} ->
        %Zoho.Response{ data: data, raw_response: response, status_code: response.status_code }
      {:error, error} ->
        {:error, error}
    end
  end

  defp parse_body(request, options) do
    case Jazz.decode(request.body) do
      {:ok, data} ->
        if success? request do
          {:ok, cast_data(data, options)}
        else
          {:ok, data}
        end
      {:error, error_message} ->
        {:error, error_message}
    end
  end
  @spec success?(Zoho.Response.http_potion_response) :: boolean
  defp success?(response) do
    HTTPotion.Response.success? response
  end

  @spec cast_data(map, map)   :: {:ok, map}
  @spec cast_data(list, map)  :: {:ok, list(map)}
  # If there is a "data" field present (for list responses), pull that out
  defp cast_data(%{"data" => data}, options) do
    cast_data(data, options)
  end

  # Just pull out known keys on the passed in `as: struct`, other than the
  # :__struct__ key
  defp cast_data(data, %{as: as_struct}) when is_map(data) do
    struct_keys = Map.keys(as_struct.__struct__) |> List.delete :__struct__
    struct(as_struct, Zoho.Utils.safe_atomize_keys(data, struct_keys))
  end

  # For lists, loop over them and cast their members
  defp cast_data(data, %{as: _struct}=options) when is_list(data) do
    Enum.map data, &cast_data(&1, options)
  end

  # If no :as option is passed, just return the data as is
  defp cast_data(data, _options) do
    data
  end
end
