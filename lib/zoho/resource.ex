defmodule Zoho.Resource do
  defmacro __using__(_) do
    quote location: :keep do
      @resource Module.get_attribute(__MODULE__, :resource) || nil
      @trailing_param_key_regex ~r/(.+)\/\:\w+\Z/

      def get(params\\%{}) do
        raw_get(params).data
      end

      def raw_get(params\\%{}) do
        build_path(@endpoint, params)
        |> Zoho.get
        |> Zoho.Response.new(%{as: @resource})
      end

      def insert(params\\%{}) do
        raw_insert(params).data
      end

      def raw_insert(params\\%{}) do
        build_post(@loc, @postendpoint, params)
        |> Zoho.get #[body: ""]
        |> Zoho.Response.new(%{as: @resource})
      end

      defp build_post(loc, path, params) do
        start = "<#{loc}><row no='1'>"
        close = "</row></#{loc}>"
        values = Enum.map(params, fn({key, value}) -> "<FL val='#{key}'>#{value}</FL>" end) |> Enum.join
        path <> URI.encode(start <> values <> close)
      end

      defp build_path(path, params) do
        Enum.reduce(params, path, &do_param_replacement/2)
        |> remove_unused_params
      end

      defp do_param_replacement({key, value}, path) do
        if String.contains? path, ":#{key}" do
          replace_param_with_value(path, key, value)
        else
          add_query_param(path, key, value)
        end
      end

      defp replace_param_with_value(path, key, value) do
        param_regex = ~r/(\/|\a)(\:#{key})(\/|\Z)/
        Regex.replace param_regex, path, fn full_match, start, param_name, finish ->
          "#{start}#{value}#{finish}"
        end
      end

      defp add_query_param(path, key, value) do
        query_param = URI.encode_query(Map.put %{}, key, value)
        if String.contains? path, "?" do
          "#{path}&#{query_param}"
        else
          "#{path}?#{query_param}"
        end
      end

      defp remove_unused_params(path) do
        if Regex.match? @trailing_param_key_regex, path do
          Regex.replace @trailing_param_key_regex, path, "\\1"
        else
          path
        end
      end
    end
  end
end
