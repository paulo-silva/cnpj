if Code.ensure_loaded?(Ecto.Changeset) do
  defmodule CNPJ.Ecto.Changeset do
    @moduledoc """
    Provide functions to validate CNPJ field in a changeset.
    """

    @type changeset :: Ecto.Changeset.t()

    @doc """
    Verifies if given `field` in the `changeset` has a valid CNPJ.

    ## Examples

        iex> {%{}, %{cnpj: :string}}
        ...>  |> Ecto.Changeset.cast(%{"cnpj" => "aaa"}, [:cnpj])
        ...>  |> CNPJ.Ecto.Changeset.validate_cnpj(:cnpj)
        ...>  |> Map.get(:errors)
        [cnpj: {"is invalid", [reason: :invalid_format]}]

        iex> {%{}, %{cnpj: :string}}
        ...>  |> Ecto.Changeset.cast(%{"cnpj" => "13.118.061.0001-08"}, [:cnpj])
        ...>  |> CNPJ.Ecto.Changeset.validate_cnpj(:cnpj)
        ...>  |> Map.get(:errors)
        []

        iex> {%{}, %{cnpj: :string}}
        ...>  |> Ecto.Changeset.cast(%{"cnpj" => "13118061000108"}, [:cnpj])
        ...>  |> CNPJ.Ecto.Changeset.validate_cnpj(:cnpj)
        ...>  |> Map.get(:errors)
        []
    """
    @spec validate_cnpj(changeset, atom) :: changeset
    def validate_cnpj(changeset, field),
      do: Ecto.Changeset.validate_change(changeset, field, &validate/2)

    defp validate(field, value) do
      case CNPJ.parse(value) do
        {:ok, _cnpj} ->
          []

        {:error, %CNPJ.ParsingError{reason: reason}} ->
          [{field, {"is invalid", [reason: reason]}}]
      end
    end
  end
end
