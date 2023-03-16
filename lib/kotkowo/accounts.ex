defmodule Kotkowo.Accounts do
  use Ash.Api

  resources do
    registry Kotkowo.Accounts.Registry
  end
end
