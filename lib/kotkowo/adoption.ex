defmodule Kotkowo.Adoption do
  use Ash.Api

  resources do
    registry Kotkowo.Adoption.Registry
  end
end
