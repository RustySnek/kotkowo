defmodule Kotkowo.Accounts.Registry do
  use Ash.Registry, extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry Kotkowo.Accounts.User
    entry Kotkowo.Accounts.Token
  end
end
