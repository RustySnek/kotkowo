defmodule Kotkowo.ManualImageSet do
  use Ash.Resource.ManualUpdate

  alias Kotkowo.Images
  alias Kotkowo.Images.CatImage

  alias Kotkowo.Adoption.Cat

  alias Ash.Changeset

  def update(%Changeset{} = changeset, opts, context) do
    args = changeset.arguments.images |> List.first()
    cat = changeset.data
    filename = Map.get(args, "filename")
    dbg(filename)
    result = CatImage.create(cat, filename)
    
    {:ok, result}
  end
end
