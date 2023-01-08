if Code.ensure_loaded?(Ecto.Type) do
  defmodule CNPJ.Ecto.Type.Bigint do
    @moduledoc false
    use Ecto.Type

    require CNPJ

    @impl true
    def type, do: :bigint

    @impl true
    def cast(%CNPJ{} = cnpj), do: {:ok, cnpj}

    def cast(input) do
      case CNPJ.parse(input) do
        {:ok, cnpj} -> {:ok, cnpj}
        {:error, %CNPJ.ParsingError{reason: reason}} -> {:error, [reason: reason]}
      end
    end

    @impl true
    def load(data) when is_integer(data), do: {:ok, CNPJ.new(data)}

    @impl true
    def dump(cnpj) do
      if CNPJ.cnpj?(cnpj), do: {:ok, CNPJ.to_integer(cnpj)}, else: :error
    end

    @impl true
    def embed_as(_format), do: :dump
  end
end
