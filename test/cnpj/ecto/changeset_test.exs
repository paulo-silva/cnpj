defmodule CNPJ.Ecto.ChangesetTest do
  use ExUnit.Case, async: true

  doctest CNPJ.Ecto.Changeset

  alias CNPJ.Ecto.Changeset
  alias CNPJ.Support.Profile

  describe "validate_cnpj" do
    test "adds error and reason to invalid cnpj field" do
      assert [cnpj: {"is invalid", [reason: :invalid_format]}] ==
               Profile.new()
               |> Profile.changeset(%{"cnpj" => "abilidebob"})
               |> Changeset.validate_cnpj(:cnpj)
               |> Map.get(:errors)
    end

    test "is ok with a valid cnpj" do
      assert [] ==
               Profile.new()
               |> Profile.changeset(%{"cnpj" => CNPJ.generate() |> to_string()})
               |> Changeset.validate_cnpj(:cnpj)
               |> Map.get(:errors)
    end
  end
end
