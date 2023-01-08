if Code.ensure_loaded?(Ecto.Type) do
  defmodule CNPJ.Ecto.Type.String do
    @moduledoc false

    use Ecto.Type

    @impl true
    def type, do: :string

    @impl true
    def cast(%CNPJ{} = cnpj), do: {:ok, cnpj}

    def cast(input) do
      case CNPJ.parse(input) do
        {:ok, cnpj} -> {:ok, cnpj}
        {:error, %CNPJ.ParsingError{reason: reason}} -> {:error, [reason: reason]}
      end
    end

    @impl true
    def load(data) when is_binary(data), do: {:ok, CNPJ.new(data)}

    @impl true
    def dump(cnpj) do
      if CNPJ.cnpj?(cnpj), do: {:ok, to_string(cnpj)}, else: :error
    end

    @impl true
    def embed_as(_format), do: :dump
  end
end
