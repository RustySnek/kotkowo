defmodule Kotkowo.Adoption.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations,
      AshGraphql.Api
    ]

  graphql do
    authorize? false # Defaults to `true`, use this to disable authorization for the entire API (you probably only want this while prototyping)
  end

  entries do
    entry Kotkowo.Adoption.Cat
  end
end
