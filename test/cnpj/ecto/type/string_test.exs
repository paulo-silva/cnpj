defmodule CNPJ.Ecto.Type.StringTest do
  use CNPJ.DataCase, async: false

  test "inserts and reads CNPJs" do
    cnpj = CNPJ.generate()

    profile = Repo.insert!(%Profile{string_cnpj: cnpj})
    profile_from_db = Repo.get(Profile, profile.id)

    assert profile_from_db.string_cnpj == cnpj
  end

  test "doesn't insert invalid CNPJs" do
    assert_raise Ecto.ChangeError, fn ->
      Repo.insert!(%Profile{string_cnpj: "abilidebob"})
    end
  end

  test "insert array of string CNPJs" do
    cnpj = CNPJ.generate()

    profile = Repo.insert!(%Profile{cnpj_string_list: [cnpj]})
    profile_from_db = Repo.get(Profile, profile.id)

    assert profile_from_db.cnpj_string_list == [cnpj]
  end

  test "insert embeded profile" do
    cnpj = CNPJ.generate()

    profile =
      Repo.insert!(%Profile{
        embed_profile: %EmbedProfile{
          string_cnpj: cnpj
        }
      })

    profile_from_db = Repo.get(Profile, profile.id)

    assert profile_from_db.embed_profile.string_cnpj == cnpj
  end

  test "queries by CNPJ" do
    cnpj = CNPJ.generate()
    profile = Repo.insert!(%Profile{string_cnpj: cnpj})

    query = from p in Profile, where: p.string_cnpj == ^cnpj

    assert [found_profile] = Repo.all(query)
    assert found_profile.id == profile.id
  end

  test "queries by CNPJ string" do
    cnpj = CNPJ.generate()
    profile = Repo.insert!(%Profile{string_cnpj: cnpj})

    query = from p in Profile, where: p.string_cnpj == ^to_string(cnpj)

    assert [found_profile] = Repo.all(query)
    assert found_profile.id == profile.id
  end

  test "queries by CNPJ integer" do
    cnpj = CNPJ.generate()
    profile = Repo.insert!(%Profile{string_cnpj: cnpj})

    query = from p in Profile, where: p.string_cnpj == ^CNPJ.to_integer(cnpj)

    assert [found_profile] = Repo.all(query)
    assert found_profile.id == profile.id
  end

  test "doesn't query with invalid CNPJs." do
    cnpj = CNPJ.generate()
    Repo.insert!(%Profile{string_cnpj: cnpj})

    query = from p in Profile, where: p.string_cnpj == ^"aaa"

    assert_raise Ecto.Query.CastError, fn ->
      Repo.all(query)
    end
  end

  test "casts CNPJs from strings on changesets" do
    cnpj = CNPJ.generate()

    assert {:ok, %Profile{string_cnpj: cast_cnpj}} =
             Profile.new()
             |> Profile.changeset(%{string_cnpj: to_string(cnpj)})
             |> apply_action(:insert)

    assert cast_cnpj == cnpj
  end

  test "casts CNPJs from integers on changesets" do
    cnpj = CNPJ.generate()

    assert {:ok, %Profile{string_cnpj: cast_cnpj}} =
             Profile.new()
             |> Profile.changeset(%{string_cnpj: CNPJ.to_integer(cnpj)})
             |> apply_action(:insert)

    assert cast_cnpj == cnpj
  end

  test "returns error on invalid CNPJs" do
    cnpj = "abilidebob"

    assert {:error, changeset} =
             Profile.new()
             |> Profile.changeset(%{string_cnpj: cnpj})
             |> apply_action(:insert)

    assert {"is invalid", details} = Keyword.get(changeset.errors, :string_cnpj)
    assert :invalid_format = Keyword.get(details, :reason)
  end
end
