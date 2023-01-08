# CNPJ
[![Elixir CI](https://github.com/paulo-silva/cnpj/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/paulo-silva/cnpj/actions/workflows/test.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/cnpj)](https://www.hex.pm/packages/cnpj)
[![Coveralls](https://img.shields.io/coveralls/github/ulissesalmeida/cnpj)](https://coveralls.io/github/ulissesalmeida/cnpj?branch=master)

CNPJ is an acronym for "Cadastro Nacional da Pessoa Jurídica," it's a identifier
number associated to companies that the Brazilian government maintains. With this
number, it is possible to check or retrieve information about a company.

This library provides a validation that checks if the number is a valid CNPJ
number. The CPF has check digit algorithm is similar to ISBN 10, you can check
the details in Portuguese [here](https://pt.wikipedia.org/wiki/Cadastro_Nacional_da_Pessoa_Jur%C3%ADdica).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cnpj` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cnpj, "~> 0.2.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cnpj](https://hexdocs.pm/cnpj).

## Quick Start

You can verify if a CNPJ is valid by calling the function `CNPJ.valid?/1`:

```elixir
CNPJ.valid?(13_118_061_000_108)
# => true

CNPJ.valid?(13_118_061_000_107)
# => false
```

## Parsing CNPJS

The `CNPJ.parse/1` and `CNPJ.parse!/1` returns you the CNPJ value wrapped in a custom type with explicit digits.

```elixir
CNPJ.parse("70947414000108")
# => {:ok, %CNPJ{digits: {7, 0, 9, 4, 7, 4, 1, 4, 0, 0, 0, 1, 0, 8}}}

CNPJ.parse("70947414000109")
# => {:error, %CNPJ.ParsingError{reason: :invalid_verifier}}

CNPJ.parse!("70947414000108")
# => %CNPJ{digits: {7, 0, 9, 4, 7, 4, 1, 4, 0, 0, 0, 1, 0, 8}}

CNPJ.parse!("70947414000109")
# => ** (CNPJ.ParsingError) invalid_verifier
```

## CNPJ Formatting

Create valid CNPJ and in sequence call `CNPJ.format/1`:

```elixir
iex> 70947414000108 |> CNPJ.parse!() |> CNPJ.format()
"70.947.414/0001-08"

iex> "70947414000108" |> CNPJ.parse!() |> CNPJ.format()
"70.947.414/0001-08"
```

The `CNPJ.format/1` expects the CNPJ type.
