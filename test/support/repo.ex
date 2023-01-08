defmodule CNPJ.Support.Repo do
  use Ecto.Repo,
    otp_app: :cnpj,
    adapter: Ecto.Adapters.Postgres
end
