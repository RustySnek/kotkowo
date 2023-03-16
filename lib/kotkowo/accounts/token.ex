defmodule Kotkowo.Accounts.Token do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource]

  token do
    api Kotkowo.Accounts
  end

  postgres do
    table "tokens"
    repo Kotkowo.Repo
  end
end
