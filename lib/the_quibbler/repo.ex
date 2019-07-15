defmodule TheQuibbler.Repo do
  use Ecto.Repo,
    otp_app: :the_quibbler,
    adapter: Ecto.Adapters.Postgres
end
