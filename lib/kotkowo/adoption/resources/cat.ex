defmodule Kotkowo.Adoption.Cat do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    table "cats"
    repo Kotkowo.Repo
  end

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
