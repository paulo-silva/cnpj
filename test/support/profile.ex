defmodule CNPJ.Support.EmbedProfile do
  @moduledoc false

  use Ecto.Schema

  import CNPJ.Ecto.Type

  embedded_schema do
    field :string_cnpj, cnpj_type(:string)
    field :integer_cnpj, cnpj_type(:bigint)
  end
end

defmodule CNPJ.Support.Profile do
  @moduledoc false

  use Ecto.Schema

  alias CNPJ.Support.EmbedProfile

  import Ecto.Changeset
  import CNPJ.Ecto.Type

  schema "profiles" do
    field :string_cnpj, cnpj_type(:string)
    field :integer_cnpj, cnpj_type(:bigint)
    field :cnpj, :string

    field :cnpj_string_list, {:array, cnpj_type(:string)}, default: []
    field :cnpj_integer_list, {:array, cnpj_type(:bigint)}, default: []

    embeds_one :embed_profile, EmbedProfile
  end

  def new(enum \\ %{}), do: struct!(__MODULE__, enum)

  def changeset(profile, params),
    do: cast(profile, params, __schema__(:fields) -- [:embed_profile])
end
