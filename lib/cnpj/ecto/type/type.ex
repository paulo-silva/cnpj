if Code.ensure_loaded?(Ecto.Type) do
  defmodule CNPJ.Ecto.Type do
    @moduledoc """
    Provide you functions to use the CNPJ type in your Ecto schema fields.

    ## Usage

        defmodule MyApp.MySchema do
          use Ecto.Schema
          # Import the cnpj_type/1 helper
          import CNPJ.Ecto.Type

          schema "my_schemas" do
            # use the helpers functions in any field
            field :cnpj, cnpj_type(:string)
          end
        end
    """

    @doc """
      A parameterized `type` macro function.

      - `cnpj_type(:bigint)` is a alias for `CNPJ.Ecto.Type.Bigint`
      - `cnpj_type(:string)` is a alias for `CNPJ.Ecto.Type.String`
    """
    @spec cnpj_type(:bigint | :string) :: Macro.t()
    defmacro cnpj_type(:bigint) do
      quote do
        CNPJ.Ecto.Type.Bigint
      end
    end

    defmacro cnpj_type(:string) do
      quote do
        CNPJ.Ecto.Type.String
      end
    end
  end
end
