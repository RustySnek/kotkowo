defmodule Kotkowo.Adoption.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations,
      AshGraphql.Api
    ]

  graphql do
    # Defaults to `true`, use this to disable authorization for the entire API (you probably only want this while prototyping)
    # authorize? false
  end

  entries do
    entry Kotkowo.Adoption.Cat
  end
end
