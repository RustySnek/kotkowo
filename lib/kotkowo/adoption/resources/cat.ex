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

    attribute :sex, :atom do
      constraints [
        one_of: [:male, :female]
      ]
    end

    attribute :age, :atom do
      constraints [
        one_of: [:junior, :senior]
      ]
    end

    attribute :fiv_felv_status, :atom do
      constraints [
        one_of: [:both_negative, :both_positive]
      ]
    end

    attribute :health_status, :atom do
      constraints [
        one_of: [:healthy, :sick]
      ]
    end

    attribute :castrated, :boolean
  end
end
