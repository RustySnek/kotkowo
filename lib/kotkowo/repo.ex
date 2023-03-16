defmodule Kotkowo.Repo do
  use AshPostgres.Repo, otp_app: :kotkowo

  def installed_extensions() do
    ["pg_trgm", "uuid-ossp", "citext"]
  end
end
