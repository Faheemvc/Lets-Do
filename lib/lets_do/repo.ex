defmodule LetsDo.Repo do
  use Ecto.Repo,
    otp_app: :lets_do,
    adapter: Ecto.Adapters.Postgres
end
