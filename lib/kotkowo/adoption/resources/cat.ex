defmodule Kotkowo.Adoption.Cat do
  use Ash.Resource

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end
  end
end
