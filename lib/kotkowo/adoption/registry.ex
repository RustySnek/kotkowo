defmodule Kotkowo.Adoption.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Kotkowo.Adoption.Cat
  end
end
