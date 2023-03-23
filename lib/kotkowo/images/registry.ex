defmodule Kotkowo.Images.Registry do
  use Ash.Registry, extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry Kotkowo.Images.Image
    entry Kotkowo.Images.CatImage
  end
end
