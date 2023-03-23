defmodule Kotkowo.Adoption.Changes.CatChange do
  use Ash.Resource.Change

  import Ash.Changeset

  def change(changeset, _options, _context) do
    images =
      get_argument(changeset, :images)
      |> Enum.map(fn img -> %{temporary_base64: img} end)

    manage_relationship(changeset, :images, images, type: :direct_control)
  end
end
