defmodule Kotkowo.ManualFetchUser do
  use Ash.Resource.ManualRead

  def read(_, _, _, %{actor: actor}) do
    {:ok, [actor]}
  end
end
