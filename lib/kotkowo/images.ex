defmodule Kotkowo.Images do
  use Ash.Api

  resources do
    registry Kotkowo.Images.Registry
  end
end
